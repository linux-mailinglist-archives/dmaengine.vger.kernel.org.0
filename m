Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3231E4A4B6F
	for <lists+dmaengine@lfdr.de>; Mon, 31 Jan 2022 17:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380118AbiAaQJ6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Jan 2022 11:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380115AbiAaQJW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Jan 2022 11:09:22 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E8AC06173D;
        Mon, 31 Jan 2022 08:08:33 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id t7so20044015ljc.10;
        Mon, 31 Jan 2022 08:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ARtnzVcNl9dDSKBaCcG/d/TntN+I4MaOYNcQFv7Q8es=;
        b=WJgmasi6ITbtf7yUBQI+682wfFnC8NExgOrfXskJFodPfm9C/g4a9x/6MquSgK2l+v
         bKS7YRlKlvMqvdl49eCdlRj2egMvplVSwzu+IKmowqK9KDJSSosROv92lxuZ7FVPKznv
         6q6ujZ9NGvFBTuAuSEkRfU/JVpaWvRyseZd/IET5NSBp8moUWd4Uybi1m6C7I55Sb/OC
         AGdsPtdWK/0j+O5qi0MlsKAuQjfqw/XOru79/3yHMMoSnmTEAr+3SapcyhkxdxbskMGg
         BFtxY8GqkAbIrOv7jfJQWgqyiQpvI4EVX20kab77BakumxUFt6ur2H/JgQ26bTamnp82
         WBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ARtnzVcNl9dDSKBaCcG/d/TntN+I4MaOYNcQFv7Q8es=;
        b=uarqhFeeFKTXgb59qF8N2rvvsuhoCuAiYBHv5V8eQVJLJjS78HAwX7BTpAtWfMKKnS
         2V11ZX3sBpGACGmuH1j5CZqOM0Gnz6M4b562+wur/9DR+dgPlEJZCa4nl8AxNT46AN76
         3sb63JjAvQPkHbeboyMy37ee9dboEyya7KsNcrEY/aOu6Q5RUkzhAY2rrMApNDEeKmut
         /ytbILRdeSQswoRT4oyiwyisYwRymsOr1few7f2fI1XvwnZicGuVxKskDmLyfhTBwDDi
         ELIxYd4O5lWWLiJqYwwrBbJunWQ100GWj0KikegrVl2f/+RwR4BzUR8keN1iwKJKmGPr
         kO0A==
X-Gm-Message-State: AOAM533iNYAaASGgNGxY+UJfPmpfyld24hPAWT4UQDDEoeSNyGAaZSRw
        GGO/cPZCJ/me5kp9GxRwogk=
X-Google-Smtp-Source: ABdhPJxymwrKsMsgUICadUNuZPe8Y4nSbOndhqHboWZkAfSn7QX1tmMD1335BwZUplbFeUA7dx3/ow==
X-Received: by 2002:a2e:3102:: with SMTP id x2mr13737332ljx.211.1643645312238;
        Mon, 31 Jan 2022 08:08:32 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-136.dynamic.spd-mgts.ru. [109.252.138.136])
        by smtp.googlemail.com with ESMTPSA id f15sm1942307lfk.198.2022.01.31.08.08.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 08:08:31 -0800 (PST)
Message-ID: <6dfdfd02-bfc3-1626-f819-7ddcc8bf9c1c@gmail.com>
Date:   Mon, 31 Jan 2022 19:08:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v17 2/4] dmaengine: tegra: Add tegra gpcdma driver
Content-Language: en-US
To:     Akhil R <akhilrajeev@nvidia.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Rajesh Gumasta <rgumasta@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Pavan Kunapuli <pkunapuli@nvidia.com>
References: <1643474453-32619-1-git-send-email-akhilrajeev@nvidia.com>
 <1643474453-32619-3-git-send-email-akhilrajeev@nvidia.com>
 <ba109465-d7ee-09cb-775b-9b702a3910b0@gmail.com>
 <DM5PR12MB1850D836ACDF95008EF74CC7C0249@DM5PR12MB1850.namprd12.prod.outlook.com>
 <08f6571e-af75-b6b3-443e-e86e3bdb365b@gmail.com>
 <DM5PR12MB1850FD5F3EF5CBFEA97B3611C0259@DM5PR12MB1850.namprd12.prod.outlook.com>
 <20220131094205.73f5f8c3@dimatab>
 <DM5PR12MB1850D677140466EC74C621A4C0259@DM5PR12MB1850.namprd12.prod.outlook.com>
 <8abf2da8-9a11-8f16-b495-d8ef2d00ab51@gmail.com>
 <DM5PR12MB18505C4CB4A34F96E74BF28FC0259@DM5PR12MB1850.namprd12.prod.outlook.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <DM5PR12MB18505C4CB4A34F96E74BF28FC0259@DM5PR12MB1850.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

31.01.2022 18:38, Akhil R пишет:
> Does the below method look good? bytes_xfer is updated on every ISR and in
> tx_status(), the wcount is read to calculate the intermittent value. If the transfer
> get complete in between, use wcount as 0 to add sg_req.len to bytes_xfer
> 
> static int tegra_dma_get_residual(struct tegra_dma_channel *tdc)
> {
> 	unsigned long wcount = 0, status;
> 	unsigned int bytes_xfer, residual;
> 	struct tegra_dma_desc *dma_desc = tdc->dma_desc;
> 	struct tegra_dma_sg_req *sg_req = dma_desc->sg_req;
> 
> 	/*
> 	 * Do not read from CHAN_XFER_COUNT if EOC bit is set
> 	 * as the transfer would have already completed and
> 	 * the register could have updated for next transfer
> 	 * in case of cyclic transfers.
> 	 */
> 	status = tdc_read(tdc, TEGRA_GPCDMA_CHAN_STATUS);
> 	if (!(status & TEGRA_GPCDMA_STATUS_ISE_EOC))
> 		wcount = tdc_read(tdc, TEGRA_GPCDMA_CHAN_XFER_COUNT);

You can't read WCOUNT after the STATUS without racing with the STATUS
updates made by h/w. You should read the WCOUNT first and only then
check the STATUS.

You should also check whether T20 tegra_dma_sg_bytes_xferred()
workarounds apply to newer h/w. I see that the h/w base hasn't changed
much since T20.

Otherwise looks okay.
