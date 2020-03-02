Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB98717584F
	for <lists+dmaengine@lfdr.de>; Mon,  2 Mar 2020 11:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbgCBK2z (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 Mar 2020 05:28:55 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35272 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgCBK2y (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 2 Mar 2020 05:28:54 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 022ASk3U103374;
        Mon, 2 Mar 2020 04:28:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583144926;
        bh=nlm/3XQud3K5oA/OPRk6fQmtXLTHYUGWQNqrE/oQIl0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=bZqLp/KoT6ouLsEWwvMlz1PGn+Is0RmLQYutPtJLXPtsH+A7JEdS9RCagDBPBabqc
         C6fCZUwQChFLtIam5Cf9uTQR1OazjkduPCQM4/8oAyQhsO/Rxe8eupIui1BUPj77o0
         NHIuGE6hdpJyRmhDSMe+mCAz0XcH5teQeUqoShVk=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 022ASk7c102771
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Mar 2020 04:28:46 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 2 Mar
 2020 04:28:46 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 2 Mar 2020 04:28:46 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 022ASiTK087603;
        Mon, 2 Mar 2020 04:28:45 -0600
Subject: Re: [PATCH v4 1/2] dmaengine: Add basic debugfs support
To:     Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <geert@linux-m68k.org>
References: <20200228130747.22905-1-peter.ujfalusi@ti.com>
 <20200228130747.22905-2-peter.ujfalusi@ti.com>
 <20200302071146.GE4148@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <7b4f244d-0855-f979-414d-e2d3cb0f0c2f@ti.com>
Date:   Mon, 2 Mar 2020 12:28:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200302071146.GE4148@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On 02/03/2020 9.11, Vinod Koul wrote:
>> diff --git a/drivers/dma/dmaengine.h b/drivers/dma/dmaengine.h
>> index e8a320c9e57c..72cd7fe33638 100644
>> --- a/drivers/dma/dmaengine.h
>> +++ b/drivers/dma/dmaengine.h
>> @@ -182,4 +182,10 @@ dmaengine_desc_callback_valid(struct dmaengine_desc_callback *cb)
>>  struct dma_chan *dma_get_slave_channel(struct dma_chan *chan);
>>  struct dma_chan *dma_get_any_slave_channel(struct dma_device *device);
>>  
>> +#ifdef CONFIG_DEBUG_FS
>> +#include <linux/debugfs.h>
>> +
>> +struct dentry *dmaengine_get_debugfs_root(void);
> 
> this needs to have an else defined with NULL return so that we dont
> force users to wrap the code under CONFIG_DEBUG_FS..

Drivers would anyways should have their debugfs related code wrapped
within ifdef. There is no point of having the code complied when it can
not be used (no debugfs support).

But I can add the  else case if we really want to:

#ifdef CONFIG_DEBUG_FS
#include <linux/debugfs.h>

struct dentry *dmaengine_get_debugfs_root(void);

#else
struct dentry;
static inline struct dentry *dmaengine_get_debugfs_root(void)
{
	return NULL;
}
#endif /* CONFIG_DEBUG_FS */


- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
