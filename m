Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1B22F26C1
	for <lists+dmaengine@lfdr.de>; Tue, 12 Jan 2021 04:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbhALDhw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Jan 2021 22:37:52 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48914 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbhALDhw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Jan 2021 22:37:52 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10C3b779060475;
        Mon, 11 Jan 2021 21:37:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1610422627;
        bh=/IgXpErguzlqPvqFvQDPoebiEgcjnHX6EGr0XrDgkcY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=RXcFuT/hxYJZPcfUKQ5uvNZOk/VkrHrRXVlakd7PpqnIJhuhBVtNKhBjfjKlvwKGG
         WMXjfU0bTu0ZH8TI786KQuNKO+wUBdBKCAIn7q5AhcM9U/2S9Hraoi1H1ulSxkvRcb
         P1Zzo8/TVTj6/7nTkcHyEfcWLQaP6R09gcUBPER4=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10C3b7Wj067138
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Jan 2021 21:37:07 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 11
 Jan 2021 21:37:06 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 11 Jan 2021 21:37:07 -0600
Received: from [10.250.235.36] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10C3b3Hc123612;
        Mon, 11 Jan 2021 21:37:04 -0600
Subject: Re: [PATCH 0/2] dmaengine: ti: k3-udma: memcpy throughput improvement
To:     <vkoul@kernel.org>
CC:     <dan.j.williams@intel.com>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <vigneshr@ti.com>,
        <grygorii.strashko@ti.com>, <peter.ujfalusi@gmail.com>
References: <20201214081310.10746-1-peter.ujfalusi@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <b3aa1dc4-170c-36f5-6095-d9861ecc9a8e@ti.com>
Date:   Tue, 12 Jan 2021 09:07:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201214081310.10746-1-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

On 14/12/20 1:43 pm, Peter Ujfalusi wrote:
> Hi,
> 
> Newer members of the KS3 family (after AM654) have support for burst_size
> configuration for each DMA channel.
> 
> The HW default value is 64 bytes but on higher throughput channels it can be
> increased to 256 bytes (UCHANs) or 128 byes (HCHANs).
> 
> Aligning the buffers and length of the transfer to the burst size also increases
> the throughput.
> 
> Numbers gathered on j721e (UCHAN pair):
> echo 8000000 > /sys/module/dmatest/parameters/test_buf_size
> echo 2000 > /sys/module/dmatest/parameters/timeout
> echo 50 > /sys/module/dmatest/parameters/iterations
> echo 1 > /sys/module/dmatest/parameters/max_channels
> 
> Prior to  this patch:   ~1.3 GB/s
> After this patch:       ~1.8 GB/s
>  with 1 byte alignment: ~1.7 GB/s
> 
> The patches are on top of the AM64 support series:
> https://lore.kernel.org/lkml/20201208090440.31792-1-peter.ujfalusi@ti.com/

FWIW, tested this series with PCIe RC<->EP (using pcitest utility)
Without this series
READ => Size: 67108864 bytes      DMA: YES        Time: 0.137854270
seconds      Rate: 475400 KB/s

WRITE => Size: 67108864 bytes     DMA: YES        Time: 0.049701495
seconds      Rate: 1318592 KB/s

With this series
READ => Size: 67108864 bytes      DMA: YES        Time: 0.045611175
seconds      Rate: 1436840 KB/s

WRITE => Size: 67108864 bytes     DMA: YES        Time: 0.042737440
seconds      Rate: 1533456 KB/s

Tested-by: Kishon Vijay Abraham I <kishon@ti.com>

Thanks
Kishon
