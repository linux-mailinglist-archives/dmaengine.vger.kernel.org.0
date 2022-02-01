Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241874A5CCB
	for <lists+dmaengine@lfdr.de>; Tue,  1 Feb 2022 14:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238339AbiBANGW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 1 Feb 2022 08:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237005AbiBANGV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 1 Feb 2022 08:06:21 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC33C06173B;
        Tue,  1 Feb 2022 05:06:20 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id b9so33706068lfq.6;
        Tue, 01 Feb 2022 05:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4zDZjUZzO0/LtwU7i9Sbk8gH9GLW2GWv2DNfc2cOlK8=;
        b=JNAn9CjthSQNVzc8E9MvXEfIRED/5Pzbf2PSwdXbtYWxzebxjpuAEdSbwVR21MPhXV
         GMOMYnR66hRxWJrFrvyxpwSivNaMAnWwH1bsUqFGgu+2g0CSZ6bennm5eoKV5/7obg/W
         HLObfWN3gn9Pm7nWbFd9N3yHAl1IHxe6JQQD+M8vc17wnU2TYTuKwjHEs2c1Ykjv1gA/
         igK5KCDPxVpzfSKsN4frwEogrZbMfnDep0GnnvhZldrioZu3jMnVWEDZRKyfwytuY+lB
         KKH/pQ7U76q83LZbOjpDl1UPLTfLSatRLWXOuWXwHzDb4DIbvCMUrCN/XLFLLj3PNvWe
         j6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4zDZjUZzO0/LtwU7i9Sbk8gH9GLW2GWv2DNfc2cOlK8=;
        b=C0+DzV/1WwV6lvpeGIcUdrIW2UtqkaYsXCfq7RhEI0xw/kWg+YlQnN9xIRovJ97aIY
         /jQ6GZp9Vd6xB67JlwWD03q80XTUA9EN7v8boobG9Nl5tBiPQIIo72DhTj7EDiicwmnY
         jpoYjar9Rx9N00BUzRxisOWkgxiMtqY7nqGtoy8kATNMQJ35CVveEvCz2z0F8dSk/4/b
         P7Mu6BIw0hAlyjQvNQwNGlQ6U7Jf7RO3jyPGH5QHcRVJK+N+uFL6MlcF23xGhOanL3ve
         cuV9O2Tgd4w4cz19GNRJKkzA9XB5J6L85alIgbDYgjS+3/E0u1UCszmVg/6my2u4kRrf
         4V5w==
X-Gm-Message-State: AOAM533Uxt45Xy8eGB8idu1iKRfSjvYK4ip9XnMilnN+v+SUQa5QOw8R
        ZAwcPoUZfE/caIV33iXv86BXTSapV6E=
X-Google-Smtp-Source: ABdhPJzQlKfW0CtWm4bXhyHTG7O7g1qPpYXDtoKXdkxclUHQ+RGjI+UtK3exNdt/OH4p05IWMjFUrw==
X-Received: by 2002:ac2:55ad:: with SMTP id y13mr19034028lfg.38.1643720778908;
        Tue, 01 Feb 2022 05:06:18 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-136.dynamic.spd-mgts.ru. [109.252.138.136])
        by smtp.googlemail.com with ESMTPSA id n15sm3344584ljh.36.2022.02.01.05.06.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 05:06:18 -0800 (PST)
Message-ID: <9900cecc-8e00-5b34-a8b2-95d8e1c1ad77@gmail.com>
Date:   Tue, 1 Feb 2022 16:06:17 +0300
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
 <6dfdfd02-bfc3-1626-f819-7ddcc8bf9c1c@gmail.com>
 <DM5PR12MB1850689286F20C18B12ADF1DC0269@DM5PR12MB1850.namprd12.prod.outlook.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <DM5PR12MB1850689286F20C18B12ADF1DC0269@DM5PR12MB1850.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

01.02.2022 15:05, Akhil R пишет:
>> 31.01.2022 18:38, Akhil R пишет:
>>> Does the below method look good? bytes_xfer is updated on every ISR and in
>>> tx_status(), the wcount is read to calculate the intermittent value. If the
>> transfer
>>> get complete in between, use wcount as 0 to add sg_req.len to bytes_xfer
>>>
>>> static int tegra_dma_get_residual(struct tegra_dma_channel *tdc)
>>> {
>>>       unsigned long wcount = 0, status;
>>>       unsigned int bytes_xfer, residual;
>>>       struct tegra_dma_desc *dma_desc = tdc->dma_desc;
>>>       struct tegra_dma_sg_req *sg_req = dma_desc->sg_req;
>>>
>>>       /*
>>>        * Do not read from CHAN_XFER_COUNT if EOC bit is set
>>>        * as the transfer would have already completed and
>>>        * the register could have updated for next transfer
>>>        * in case of cyclic transfers.
>>>        */
>>>       status = tdc_read(tdc, TEGRA_GPCDMA_CHAN_STATUS);
>>>       if (!(status & TEGRA_GPCDMA_STATUS_ISE_EOC))
>>>               wcount = tdc_read(tdc, TEGRA_GPCDMA_CHAN_XFER_COUNT);
>>
>> You can't read WCOUNT after the STATUS without racing with the STATUS
>> updates made by h/w. You should read the WCOUNT first and only then
>> check the STATUS.
>>
>> You should also check whether T20 tegra_dma_sg_bytes_xferred()
>> workarounds apply to newer h/w. I see that the h/w base hasn't changed
>> much since T20.
> The calculation in T20 driver is not applicable here. The register shows the
> actual number of words remaining to be transferred as far as I understand.

If downstream kernel DMA driver doesn't have any special quirks, then
likely that they are indeed unneeded.
