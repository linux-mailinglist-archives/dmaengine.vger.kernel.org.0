Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD4B46F5E3
	for <lists+dmaengine@lfdr.de>; Thu,  9 Dec 2021 22:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhLIVaK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 9 Dec 2021 16:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhLIVaJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 9 Dec 2021 16:30:09 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BCCC061746;
        Thu,  9 Dec 2021 13:26:35 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id t26so14502205lfk.9;
        Thu, 09 Dec 2021 13:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ronGa8kaM21d9j/wqqDIPAJlsnKXUKmxS5KwXQbVdi0=;
        b=H4nNZGGdvDC8N1f5VXViP8mR5Z33RG5Aq56EeMtdHniKdlPNMFq1+G+ozHDBfbIWGn
         T/tLW7vgf+qjm9vKiNP6eaeHwQ758XmdXPFfjniNfcQHRPy0WQO31SKuvq+y8XtK2gbn
         e2TptH266ePgIgIY6QaUBOK5Rd0gTnCsCaWksP8U/6ZJBrz8/ip2TONEiJA7wAR5YKBY
         A2UnOvJE6xoPh6lgFDk5M9oZdXWMc+lhXn5qr6HFwxeZU1SzluO0maPl449deYN44Zw7
         ToryQhOISL/XRkI2dpZ9kfxSd1ch0nGQPvY8CwfnwdcjWb22tj5mNiVlZvvaGMxvCg4X
         KRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ronGa8kaM21d9j/wqqDIPAJlsnKXUKmxS5KwXQbVdi0=;
        b=R13d1VKXoy0D4F0BTRYDkiK7ouMfhNrDuXMIkDDqnfcw3ZlpsCtIYIlsezbpcdvoIp
         Iwz6xV3CQ7L/4ct9YIWJ9W+NCvCBE4oaIMSgKtnenIRFB6X3lATY4L79DWyPmTFwLZhx
         B73YIsd4DqTDhoQOpe/3Gh0Cccflv565rthzcvtCyWJzk6nhJxw+jX2ihRBfpiOI8psa
         rrWpX4lMRlqvn/RsU4tmd01K9aLAANDB8otXzG8vlW8f6p9mAVOx4zIgycHOs0nb3r5f
         R4ngtEOln47+U9nWoLss4QEF3e0saJ31+DwV5EwQYToBgRyPk2qm6M7XWrDvOKqbRyrs
         DWkQ==
X-Gm-Message-State: AOAM5329sV5AJc/KAKtoO+4TUA7O1TiRB/jlUMLzZbc+KFbJKAnkaCcF
        qOLzxh6TqpNzN9CMF5DjfXk=
X-Google-Smtp-Source: ABdhPJz7WQIl4laGZsOJDF3sulSSpRjSf86rPaN0VrE/5YLw1xRsIXfBCq+O5H6CKUcuvjNLr8Qq6A==
X-Received: by 2002:a05:6512:11e5:: with SMTP id p5mr8149686lfs.537.1639085193944;
        Thu, 09 Dec 2021 13:26:33 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.googlemail.com with ESMTPSA id f35sm108980lfv.98.2021.12.09.13.26.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 13:26:33 -0800 (PST)
Subject: Re: [PATCH v14 2/4] dmaengine: tegra: Add tegra gpcdma driver
To:     Akhil R <akhilrajeev@nvidia.com>, dan.j.williams@intel.com,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        jonathanh@nvidia.com, kyarlagadda@nvidia.com, ldewangan@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        p.zabel@pengutronix.de, rgumasta@nvidia.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, vkoul@kernel.org
Cc:     Pavan Kunapuli <pkunapuli@nvidia.com>
References: <1638795639-3681-1-git-send-email-akhilrajeev@nvidia.com>
 <1638795639-3681-3-git-send-email-akhilrajeev@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ac24b494-1ea2-088c-a6b0-01f58ae6321f@gmail.com>
Date:   Fri, 10 Dec 2021 00:26:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1638795639-3681-3-git-send-email-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

06.12.2021 16:00, Akhil R пишет:
> +MODULE_ALIAS("platform:tegra-gpc-dma");

This is unneeded by OF and ACPI drivers.
