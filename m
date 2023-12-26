Return-Path: <dmaengine+bounces-666-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AAA81EA1C
	for <lists+dmaengine@lfdr.de>; Tue, 26 Dec 2023 22:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07BE9B21450
	for <lists+dmaengine@lfdr.de>; Tue, 26 Dec 2023 21:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86B44C7D;
	Tue, 26 Dec 2023 21:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wtobl/rV"
X-Original-To: dmaengine@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C14D4C6D;
	Tue, 26 Dec 2023 21:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=zZx5kKQbNvGQh3eyqh31c9/X5hSZ2Ot+vN8zFxvK8X0=; b=wtobl/rV68n1AfTgpRE0QtbMeu
	RbE56tT9blAgDtGaxWWhtZPtfRFxX5k+koqPs2RdMb7nrZLXvwA/2/g8kkDmsmIlxjkLFka9vrNRC
	y7KfMTnienWGkF5+PuuQ6aTgJHwlb/K6C8Dg7u4mGx6EZ8jMiITEct5vdO4/uAQ4e/BPfJTKAfDCi
	D3NOnqaj954ClTXvBP+W72OOPijt3mKXRK7nlSUBjdEfAnNRDccJEUOYmgnPLaiEE/9T1jXrittFu
	9VA00EfHPy9uPF3Q4oZGW3Mbr8mJ+5fa222mFTF53shAJQCvUFk2uJpLqY9iS7ci/5NEPLjc13pVC
	/RlALUsQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rIEgN-00DY2a-0U;
	Tue, 26 Dec 2023 21:09:47 +0000
Message-ID: <ba080e23-18b1-4ab5-baa8-62bc09a98e38@infradead.org>
Date: Tue, 26 Dec 2023 13:09:46 -0800
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
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <00e3eea06f5dde61734a53af797b190692060aab.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

On 12/26/23 12:53, Tom Zanussi wrote:
> In some configurations e.g. systems with CXL, a numa node can have 0
> cpus and cpumask_nth() will return a cpu value that doesn't exist,
> which will result in an attempt to add an entry to the wq table at a
> bad index.
> 
> To fix this, when iterating the cpus for a node, skip any node that
> doesn't have cpus.
> 
> Also, as a precaution, add a warning and bail if cpumask_nth() returns
> a nonexistent cpu.
> 
> Reported-by: Zhang, Rex <rex.zhang@intel.com>
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---
>  drivers/crypto/intel/iaa/iaa_crypto_main.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
> index 5093361b0107..782157a74043 100644
> --- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
> +++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
> @@ -1017,12 +1017,17 @@ static void rebalance_wq_table(void)
>  		return;
>  	}
>  
> -	for_each_online_node(node) {
> +	for_each_node_with_cpus(node) {
>  		node_cpus = cpumask_of_node(node);
>  
>  		for (cpu = 0; cpu < nr_cpus_per_node; cpu++) {
>  			int node_cpu = cpumask_nth(cpu, node_cpus);
>  
> +			if (WARN_ON(node_cpu >= nr_cpu_ids)) {
> +				pr_debug("node_cpu %d doesn't exist!\n", node_cpu);
> +				return;
> +			}
> +
>  			if ((cpu % cpus_per_iaa) == 0)
>  				iaa++;
>  
> @@ -2095,10 +2100,13 @@ static struct idxd_device_driver iaa_crypto_driver = {
>  static int __init iaa_crypto_init_module(void)
>  {
>  	int ret = 0;
> +	int node;
>  
>  	nr_cpus = num_online_cpus();
> -	nr_nodes = num_online_nodes();
> -	nr_cpus_per_node = nr_cpus / nr_nodes;
> +	for_each_node_with_cpus(node)
> +		nr_nodes++;
> +	if (nr_nodes)
> +		nr_cpus_per_node = nr_cpus / nr_nodes;

If nr_nodes == 0, nr_cpus_per_node is not initialized here.
Is it initialized somewhere else, or just not used if nr_nodes is 0?

>  
>  	if (crypto_has_comp("deflate-generic", 0, 0))
>  		deflate_generic_tfm = crypto_alloc_comp("deflate-generic", 0, 0);

-- 
#Randy

