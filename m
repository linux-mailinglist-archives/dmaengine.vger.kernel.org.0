Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA977475B25
	for <lists+dmaengine@lfdr.de>; Wed, 15 Dec 2021 15:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243583AbhLOO40 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Dec 2021 09:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243575AbhLOO4Z (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Dec 2021 09:56:25 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA356C06173E;
        Wed, 15 Dec 2021 06:56:24 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id u22so33686892lju.7;
        Wed, 15 Dec 2021 06:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VlpUM4pVnFF7b/v49q5hG/QwrE0qXlxltwh39I/Lb3U=;
        b=aa6oe37gkeikvLqkgQh4Y837T645JoVUUPcc6Rkd9TBbGuzq8J7gfQnQJxKEfazilm
         xjVa0jXe5Rizo7oGsjIlD+H4jIPSNziX6oKVz1TfSZKcy/UyUwX7Y3Uxcqnla9a+N0+7
         PGaF+FerxDS3CvJKQxLCUk/m478BUgaON1nKCFZjUCzTVUCsAIqHnBNtZW5iuchZkwgT
         yWKQqC4UGy8UZ0i36y0hM73bTREHeJzrl9AGWHAkjz9sUBSRVAmQXd956vjX+GTSI3hw
         OK7zVF+Lr4VZu9yE9dt/aGk6xRHkfRz/GVlTbCVf11Nl9HNlXmJ0RQ4s01FEdcUSl+gy
         VeqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VlpUM4pVnFF7b/v49q5hG/QwrE0qXlxltwh39I/Lb3U=;
        b=Z2qHA55au2qwu6s21olx0D4NVmqk/HaxsgDYmGw10K2Dosvk9Y5dSEo2Kb6mR6Tvai
         25TYuckmD8vrvNuqPcn334rv/aonX1gt6zHHmuIPgjljAKTIfwb8Qguj2g29Hrr0AHPs
         NzleO6L/u5OPrCd//caB6EL7rqsHSbHyGdwWLadzw6JNu9C2HQ2IIGfOwj9Se2JZ7aTy
         xGOaTzW6WFdc3Fk96Nx8FRI8qYQiC5OmyUShiJ3uhcsnzgkjf7eBNqT4Y6kXLLtXIrq3
         ZXq3qVirb76zGbZd9M1QkPExKMyGa+DQKHAZWA6/9IQGO+bQuwrzx5mhlsbua6Qvf+ix
         Nsig==
X-Gm-Message-State: AOAM532n/i/TcpAK8cQ7NmEhfjYSBeSx08X9DlJQb8gUjVCLSXoZIVRq
        1WnbKuTSNzg/5U/G4x2jL+STSy2Goqg=
X-Google-Smtp-Source: ABdhPJxtZzId3hlV/qfDQ7GjmHdzLoX/TCsop5PDpRClHgQYUT0FtHwvACVezQ3yUAbTdn7cYaU8bw==
X-Received: by 2002:a2e:9903:: with SMTP id v3mr10380295lji.143.1639580182548;
        Wed, 15 Dec 2021 06:56:22 -0800 (PST)
Received: from [192.168.2.145] (94-29-63-156.dynamic.spd-mgts.ru. [94.29.63.156])
        by smtp.googlemail.com with ESMTPSA id c34sm357937lfv.83.2021.12.15.06.56.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 06:56:22 -0800 (PST)
Subject: Re: [PATCH v14 2/4] dmaengine: tegra: Add tegra gpcdma driver
To:     Akhil R <akhilrajeev@nvidia.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
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
        "vkoul@kernel.org" <vkoul@kernel.org>
Cc:     Pavan Kunapuli <pkunapuli@nvidia.com>
References: <1638795639-3681-1-git-send-email-akhilrajeev@nvidia.com>
 <1638795639-3681-3-git-send-email-akhilrajeev@nvidia.com>
 <3f7b072d-f108-ebce-e862-eff9869d1d92@gmail.com>
 <BN9PR12MB52738F4B5B7494466A9CB5A1C0769@BN9PR12MB5273.namprd12.prod.outlook.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <70cce574-4022-16a9-ae10-4b84696d21d5@gmail.com>
Date:   Wed, 15 Dec 2021 17:56:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <BN9PR12MB52738F4B5B7494466A9CB5A1C0769@BN9PR12MB5273.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

15.12.2021 16:50, Akhil R пишет:
>> 06.12.2021 16:00, Akhil R пишет:
>>> +static const struct __maybe_unused dev_pm_ops tegra_dma_dev_pm_ops =
>> {
>>> +     SET_LATE_SYSTEM_SLEEP_PM_OPS(tegra_dma_pm_suspend,
>>> +tegra_dma_pm_resume) };
>>
>> Why late?
> To wait for the drivers using the dma to be suspended so that they
> don't keep the dma busy.
> Agree with the other comments.

Drivers are suspended in the opposite order to the probe order. DMA
controller driver is always probed first. The "late" is unneeded, please
see tegra20-apb-dma driver for the example.
