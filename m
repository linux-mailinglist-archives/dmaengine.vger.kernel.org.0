Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C368127777
	for <lists+dmaengine@lfdr.de>; Fri, 20 Dec 2019 09:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfLTIsB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 20 Dec 2019 03:48:01 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58524 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbfLTIsB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 20 Dec 2019 03:48:01 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBK8lkiC080256;
        Fri, 20 Dec 2019 02:47:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576831667;
        bh=Y8SJjnPJ2zTuwuUuXvi/iusPn5VXym1DpE2Ni2sJVGo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ttjR8bV7NcwEdlkksg4iqfMbc72kqxA+NZTKn9KmxuhtXaL3iKjJXdhaOe2e/Ezqv
         nbs7Au55+6yRYcCGdvlleszGHyIlbb+kJmuFygZ5ljUOwzoBIN2whH0Z78c5MJHrjJ
         Izudz+vTDeyFhiiD6C7C8kAp+755Iw8c7TO64hFI=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBK8lkr6065686;
        Fri, 20 Dec 2019 02:47:46 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 20
 Dec 2019 02:47:46 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 20 Dec 2019 02:47:46 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBK8lgp6045691;
        Fri, 20 Dec 2019 02:47:43 -0600
Subject: Re: [PATCH v7 04/12] dmaengine: Add metadata_ops for
 dma_async_tx_descriptor
To:     Vinod Koul <vkoul@kernel.org>
CC:     <robh+dt@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <j-keerthy@ti.com>,
        <vigneshr@ti.com>
References: <20191209094332.4047-1-peter.ujfalusi@ti.com>
 <20191209094332.4047-5-peter.ujfalusi@ti.com>
 <20191220083216.GK2536@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <8f66594b-3c4a-dae2-9445-0e7d28e017b8@ti.com>
Date:   Fri, 20 Dec 2019 10:48:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191220083216.GK2536@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On 20/12/2019 10.32, Vinod Koul wrote:
> Hi Peter,
> 
> On 09-12-19, 11:43, Peter Ujfalusi wrote:
> 
>> +int dmaengine_desc_attach_metadata(struct dma_async_tx_descriptor *desc,
>> +				   void *data, size_t len)
>> +{
>> +	int ret;
>> +
>> +	if (!desc)
>> +		return -EINVAL;
>> +
>> +	ret = desc_check_and_set_metadata_mode(desc, DESC_METADATA_CLIENT);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (!desc->metadata_ops || !desc->metadata_ops->attach)
>> +		return -ENOTSUPP;
>> +
>> +	return desc->metadata_ops->attach(desc, data, len);
> 
> this looks good to me, only thing is we should check if people are
> mixing the modes :)

desc_check_and_set_metadata_mode() does the checking to make sure that
the modes are not mixed.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
