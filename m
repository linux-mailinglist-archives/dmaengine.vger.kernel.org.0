Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFAB013DFAB
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jan 2020 17:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgAPQMC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Jan 2020 11:12:02 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52102 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbgAPQL7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Jan 2020 11:11:59 -0500
Received: by mail-wm1-f66.google.com with SMTP id d73so4360073wmd.1
        for <dmaengine@vger.kernel.org>; Thu, 16 Jan 2020 08:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wq116TZAe0p40heVVDfMLRBuWEj6xKtwx1Np2GXHzlk=;
        b=qdQEY1n8v+dLZaHvHfDyqgC04UQvFEYkL0iVEjWLFmsSkU3RdqM+lv6eJPlKsfZZJo
         V2U5I8ZZfySoMK28rBSpL6Qi9hZ1hBksNdUKrrlpCgVLxMi5EXSi5jSaVoIKprkgosd5
         tsDC/ZoH/IOGHUHa5cOqrpght5pR8sZ8tAU7KkBzmrV/NVIcLC4BYWkLn3qFk7vMY0dG
         3cUuGjOTM7lrJfGCwT9DuQ2es9Hy/CCF+RThAtg047ML104Uh1CTu5cc9rYcPLtsT3GC
         B/ZdafPWXHclyQ++k9xdn+0fxAl7T0KV1vSnNRH8BNknm6iXsf0sfW0O3mzquuFtLaDf
         naeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wq116TZAe0p40heVVDfMLRBuWEj6xKtwx1Np2GXHzlk=;
        b=ASZ3Eue37bMfdhIMTp7ig0iquR4r+fwqaqCIFNND0SFvw40oi4wbq0DDc5iSmDfAkV
         PjUMqN7GmKlCAwZglAAujwYKyB7rI3ha09pDmFlLuO8nCbFNtX1Cn/zZewi9Kx3uOWP1
         wgIbA4K8feRRx1ORRiBeoum/lK13KNEXp19PqZYRGqTWaFjrJiosCns8VEfTLAZPPgH9
         9l73Oa05oFWFPeeWkOi30Z1NSn1fIBwqHLBXPO56vXqxtcgyG1cAULwA+DQLtn5IQ/35
         rqgdH7iLnNdDqJE3ZjUR1kdAuTBUL/PI/74dtqvBGU+dFSZRf94sw8+OpT0CjU2GfkzG
         lyDg==
X-Gm-Message-State: APjAAAXgELc75W/XssXlPfBhf+5YTPM4HA5mKOtr9ucEIJsehxa5MJ1U
        my+RTocV96HGvvKs/mWizys/Qw==
X-Google-Smtp-Source: APXvYqxia/hYDamKXklRlZ4uVwwfWKaRzmR3+FORgkBCwOjEeD6jP03Gwc0fSu+Qsj8bDjor8a5sTA==
X-Received: by 2002:a1c:a982:: with SMTP id s124mr6705085wme.132.1579191117317;
        Thu, 16 Jan 2020 08:11:57 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id i5sm30424978wrv.34.2020.01.16.08.11.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Jan 2020 08:11:55 -0800 (PST)
Subject: Re: [PATCH V2 3/7] dt-bindings: imx-ocotp: Add i.MX8MP compatible
To:     Anson Huang <Anson.Huang@nxp.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, vkoul@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        ulf.hansson@linaro.org, broonie@kernel.org,
        manivannan.sadhasivam@linaro.org, andrew.smirnov@gmail.com,
        rjones@gateworks.com, marcel.ziswiler@toradex.com,
        sebastien.szymanski@armadeus.com, aisheng.dong@nxp.com,
        richard.hu@technexion.com, angus@akkea.ca, cosmin.stoica@nxp.com,
        l.stach@pengutronix.de, rabeeh@solid-run.com,
        leonard.crestez@nxp.com, daniel.baluta@nxp.com, jun.li@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     Linux-imx@nxp.com
References: <1578893602-14395-1-git-send-email-Anson.Huang@nxp.com>
 <1578893602-14395-3-git-send-email-Anson.Huang@nxp.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <c2c3d925-a69a-d7f8-a58a-5f4abe46960b@linaro.org>
Date:   Thu, 16 Jan 2020 16:11:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1578893602-14395-3-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 13/01/2020 05:33, Anson Huang wrote:
> Add compatible and description for i.MX8MP.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied Thanks,

--srini
