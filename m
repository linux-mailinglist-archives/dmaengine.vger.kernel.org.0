Return-Path: <dmaengine+bounces-668-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C70581EAC0
	for <lists+dmaengine@lfdr.de>; Wed, 27 Dec 2023 00:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2D751C21460
	for <lists+dmaengine@lfdr.de>; Tue, 26 Dec 2023 23:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4777C107A4;
	Tue, 26 Dec 2023 23:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UNr+0MF6"
X-Original-To: dmaengine@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB71010787;
	Tue, 26 Dec 2023 23:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=BqckLO0J2wLmYBeDPhl7hbzhV0iTqum60ch7zq4z1J8=; b=UNr+0MF6xbnUEt/k2WgoTWXHe4
	hLHbzyjX2R41L3ALjN5MoFMxYhr0/OzFgssH+9syhFyPXD+MD0VGMNKiTXoHyIRWKqoIiVG/bB9l3
	hy5+3GW4Dqa+79JEj2+g7j0RU6JzZ5mvTgL34luJ0fUUyv78ECEO9H52tjOqrLJEgDspIxPinqOAL
	ssCZvOtY1/24vyyv1r4mc5xTkrb3GN6NSjCx583hTMDLHwUqdGBXItx1H/puaSluBy55fljDMMS+K
	utWJ5JwTAn0HEYD+D4a+/K7GuNRSQgx7x1pk+aJYYfpum2StyPidD7Tj0T61HZc5MDBqxp9oU2VOB
	NVZEUNlA==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rIGmx-00DfEJ-0F;
	Tue, 26 Dec 2023 23:24:43 +0000
Message-ID: <ccb01eb2-7a8f-4635-95ab-df9791c02f51@infradead.org>
Date: Tue, 26 Dec 2023 15:24:42 -0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crypto: iaa - Account for cpu-less numa nodes
Content-Language: en-US
To: Tom Zanussi <tom.zanussi@linux.intel.com>, herbert@gondor.apana.org.au,
 davem@davemloft.net, fenghua.yu@intel.com
Cc: rex.zhang@intel.com, dave.jiang@intel.com, tony.luck@intel.com,
 linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
 dmaengine@vger.kernel.org
References: <00e3eea06f5dde61734a53af797b190692060aab.camel@linux.intel.com>
 <ba080e23-18b1-4ab5-baa8-62bc09a98e38@infradead.org>
 <62ec89d8633a9a6814d502eb0a9d44714659d06a.camel@linux.intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <62ec89d8633a9a6814d502eb0a9d44714659d06a.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/26/23 14:04, Tom Zanussi wrote:
> Hi Randy,
> 
> On Tue, 2023-12-26 at 13:09 -0800, Randy Dunlap wrote:
>> Hi--
>>
>> On 12/26/23 12:53, Tom Zanussi wrote:
>>> In some configurations e.g. systems with CXL, a numa node can have
>>> 0
>>> cpus and cpumask_nth() will return a cpu value that doesn't exist,
>>> which will result in an attempt to add an entry to the wq table at
>>> a
>>> bad index.
>>>
>>> To fix this, when iterating the cpus for a node, skip any node that
>>> doesn't have cpus.
>>>
>>> Also, as a precaution, add a warning and bail if cpumask_nth()
>>> returns
>>> a nonexistent cpu.
>>>
>>> Reported-by: Zhang, Rex <rex.zhang@intel.com>
>>> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
>>> ---
>>>  drivers/crypto/intel/iaa/iaa_crypto_main.c | 14 +++++++++++---
>>>  1 file changed, 11 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c
>>> b/drivers/crypto/intel/iaa/iaa_crypto_main.c
>>> index 5093361b0107..782157a74043 100644
>>> --- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
>>> +++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
>>> @@ -1017,12 +1017,17 @@ static void rebalance_wq_table(void)
>>>                 return;
>>>         }
>>>  
>>> -       for_each_online_node(node) {
>>> +       for_each_node_with_cpus(node) {
>>>                 node_cpus = cpumask_of_node(node);
>>>  
>>>                 for (cpu = 0; cpu < nr_cpus_per_node; cpu++) {
>>>                         int node_cpu = cpumask_nth(cpu, node_cpus);
>>>  
>>> +                       if (WARN_ON(node_cpu >= nr_cpu_ids)) {
>>> +                               pr_debug("node_cpu %d doesn't
>>> exist!\n", node_cpu);
>>> +                               return;
>>> +                       }
>>> +
>>>                         if ((cpu % cpus_per_iaa) == 0)
>>>                                 iaa++;
>>>  
>>> @@ -2095,10 +2100,13 @@ static struct idxd_device_driver
>>> iaa_crypto_driver = {
>>>  static int __init iaa_crypto_init_module(void)
>>>  {
>>>         int ret = 0;
>>> +       int node;
>>>  
>>>         nr_cpus = num_online_cpus();
>>> -       nr_nodes = num_online_nodes();
>>> -       nr_cpus_per_node = nr_cpus / nr_nodes;
>>> +       for_each_node_with_cpus(node)
>>> +               nr_nodes++;
>>> +       if (nr_nodes)
>>> +               nr_cpus_per_node = nr_cpus / nr_nodes;
>>
>> If nr_nodes == 0, nr_cpus_per_node is not initialized here.
>> Is it initialized somewhere else, or just not used if nr_nodes is 0?
>>
> 
> nr_cpus_per_node is initialized to 0 elsewhere (as a static global).
> 
> It seems to me nr_nodes should always be at least 1.  From my testing
> with !CONFIG_NUMA, nr_nodes is set to 1 in that case; not sure how you
> can get actually get nr_nodes == 0 if you have any cpus working.  The
> check is there to avoid dividing by 0 but maybe the right thing to is
> BUG_ON(!nr_nodes) and return an error, and remove that check...

I think it's OK as is then.

and I hope that we never see the WARN_ON() up above. :)

>>>  
>>>         if (crypto_has_comp("deflate-generic", 0, 0))
>>>                 deflate_generic_tfm = crypto_alloc_comp("deflate-
>>> generic", 0, 0);
>>
> 

Thanks.
-- 
#Randy

