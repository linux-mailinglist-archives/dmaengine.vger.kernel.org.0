Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 006A71759CB
	for <lists+dmaengine@lfdr.de>; Mon,  2 Mar 2020 12:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbgCBLyE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 Mar 2020 06:54:04 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:49236 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbgCBLyE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 2 Mar 2020 06:54:04 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 022BrpRx069790;
        Mon, 2 Mar 2020 05:53:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583150031;
        bh=r1oFGQAljQ37WL7mkb3z3+k9czKzVZLG9ut5lfbWRS0=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=ZyDJyjbFdtj+c7m1/sKMjH6zESrVG3Jrexn1gXjkpBtce83pmyl2gfvaXV/YwZfLH
         inh6NIM0A0p1DMJU61NPYukioclBBCbqpdbfVJhg+iwktZo4EQuvhqqYA9+TUB/XiJ
         VFiZNPGcBDKwugudEEuzzaA0hWdX7L3lUaFL6sfU=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 022Brpmn110675
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Mar 2020 05:53:51 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 2 Mar
 2020 05:53:51 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 2 Mar 2020 05:53:51 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 022Brn1F101010;
        Mon, 2 Mar 2020 05:53:50 -0600
Subject: Re: [PATCH v4 1/2] dmaengine: Add basic debugfs support
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <geert@linux-m68k.org>
References: <20200228130747.22905-1-peter.ujfalusi@ti.com>
 <20200228130747.22905-2-peter.ujfalusi@ti.com>
 <20200302071146.GE4148@vkoul-mobl>
 <7b4f244d-0855-f979-414d-e2d3cb0f0c2f@ti.com>
Message-ID: <be7d4df5-121b-0eec-b68c-fa3b5cffc8c9@ti.com>
Date:   Mon, 2 Mar 2020 13:53:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <7b4f244d-0855-f979-414d-e2d3cb0f0c2f@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 02/03/2020 12.28, Peter Ujfalusi wrote:
> Hi Vinod,
> 
> On 02/03/2020 9.11, Vinod Koul wrote:
>>> diff --git a/drivers/dma/dmaengine.h b/drivers/dma/dmaengine.h
>>> index e8a320c9e57c..72cd7fe33638 100644
>>> --- a/drivers/dma/dmaengine.h
>>> +++ b/drivers/dma/dmaengine.h
>>> @@ -182,4 +182,10 @@ dmaengine_desc_callback_valid(struct dmaengine_desc_callback *cb)
>>>  struct dma_chan *dma_get_slave_channel(struct dma_chan *chan);
>>>  struct dma_chan *dma_get_any_slave_channel(struct dma_device *device);
>>>  
>>> +#ifdef CONFIG_DEBUG_FS
>>> +#include <linux/debugfs.h>
>>> +
>>> +struct dentry *dmaengine_get_debugfs_root(void);
>>
>> this needs to have an else defined with NULL return so that we dont
>> force users to wrap the code under CONFIG_DEBUG_FS..
> 
> Drivers would anyways should have their debugfs related code wrapped
> within ifdef. There is no point of having the code complied when it can
> not be used (no debugfs support).
> 
> But I can add the  else case if we really want to:
> 
> #ifdef CONFIG_DEBUG_FS
> #include <linux/debugfs.h>
> 
> struct dentry *dmaengine_get_debugfs_root(void);
> 
> #else
> struct dentry;
> static inline struct dentry *dmaengine_get_debugfs_root(void)
> {
> 	return NULL;
> }
> #endif /* CONFIG_DEBUG_FS */

It might be even better if the core creates directories for the dma
controllers in dma_async_device_register() and removes the whole
directory in dma_async_device_unregister()

Then drivers can get their per device root via:
#ifdef CONFIG_DEBUG_FS
static inline struct dentry *
dmaengine_get_debugfs_root(struct dma_device *dma_dev) {
	return dma_dev->dbg_dev_root;
}
#else
struct dentry;
static inline struct dentry *
dmaengine_get_debugfs_root(struct dma_device *dma_dev)
{
	return NULL;
}
#endif /* CONFIG_DEBUG_FS */

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
