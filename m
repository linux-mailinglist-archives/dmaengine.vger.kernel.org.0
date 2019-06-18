Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8566D4A4DB
	for <lists+dmaengine@lfdr.de>; Tue, 18 Jun 2019 17:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729249AbfFRPMI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Jun 2019 11:12:08 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37457 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729242AbfFRPME (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Jun 2019 11:12:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id v14so14413018wrr.4
        for <dmaengine@vger.kernel.org>; Tue, 18 Jun 2019 08:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XMfa9NJpDXh8dDL9yFLkdc/RmjSvoaHVSjRiYPgy7AU=;
        b=RzFJ/8d2DQVpdpSN66TgWH5FYsc9Os+fcsszwdEdRiHoXMgA1PIV3bLurXKkC7Yfm2
         WouFAm13XKYXcw2na3YdFMwyVTomRiE8GcJt7T0UkpCALOrQqSInLzUwFkKfsM2JiAKW
         axUHeuXw1lVc5yE9i0Nno/wdZI8oyrbEgvtmwDzTRYtZcIp30ff4W0yvUt2j7xoA/gTZ
         wyC+bN6bQhAd750oPFey+eCSuBBvM3yTCzeAeBlUC83k4E7dzSdV5lcDYAFUBwa1CSOt
         KlTXHV8Lm/JLy7emfb3OUwFyo8Y3WlHJhQTy+jrci8gAf78nCdsOuN2ZG2JIv2gv7chT
         pr/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XMfa9NJpDXh8dDL9yFLkdc/RmjSvoaHVSjRiYPgy7AU=;
        b=nGITAt+tJ8XsE2bd1a3bTCs01JS5rk+ecm0gpYMATu7CKQDOAX98vlRDI3+Bj6HkIo
         PnKVL6Xaeyj3afCnSd4Zt/WGAnAAmY0orCu2uIwN+ZvKEms8+coTf9QvdeC0w0sFz7/p
         Og9h6rzlcf+iNv99qSKv7bhlT5ydwe6nkD6JSImMk8AuiX0RNQoEWGou3YIoS6BH5q8j
         aPnXlozOTb+XLWYgDWfJTRRX2XFPRD0t4QVeoiOIy5wXGYlewZeGUmd1qg+GSAYoSN+G
         Qal9Ow3w1cDBEn+/OdGRgWgkfMY0d48lHGjEXqpuU54442f2FEV0hEBvQxscTdbLAdMJ
         EYGQ==
X-Gm-Message-State: APjAAAXJ2y50gPwOnI2wKqPPkHR5py5QohQhowQgUTDj+8MnB4/occ3H
        8cqoB4fmEML4faT8XpRqdqf9Cg+jGr4B2g==
X-Google-Smtp-Source: APXvYqyrqTtNMWynSOgiXHoVZjhnncDqEEw1XV2KrhXPMaVDno3t7MXb5Vtc1ZRd/MUwl+UmMXGINA==
X-Received: by 2002:a5d:488b:: with SMTP id g11mr5139572wrq.72.1560870722429;
        Tue, 18 Jun 2019 08:12:02 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id x83sm2964625wmb.42.2019.06.18.08.12.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 08:12:01 -0700 (PDT)
Subject: Re: [PATCH] dmaengine: qcom-bam: fix circular buffer handling
To:     Sricharan R <sricharan@codeaurora.org>, vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20190614142012.31384-1-srinivas.kandagatla@linaro.org>
 <f4522b78-b406-954c-57b7-923e6ab31f96@codeaurora.org>
 <d84af3ad-5ba4-0f24-fd30-2fa20cf85658@linaro.org>
 <2d370a33-fa16-45ca-cf82-9d775349f806@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <544851f6-58b8-2506-01ce-5c4d1f93fb3c@linaro.org>
Date:   Tue, 18 Jun 2019 16:12:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <2d370a33-fa16-45ca-cf82-9d775349f806@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 18/06/2019 15:56, Sricharan R wrote:
>    So MAX_DESCRIPTORS is used in driver for masking head/tail pointers.
>    That's why we have to pass MAX_DESCRIPTORS + 1 so that it works
>    when the Macros does a size - 1
Isn't that incorrect to do that, pretending to have more descriptors 
than we actually have?

--srini
