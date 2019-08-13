Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3BD8B2C9
	for <lists+dmaengine@lfdr.de>; Tue, 13 Aug 2019 10:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfHMIoh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Aug 2019 04:44:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41371 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfHMIog (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 13 Aug 2019 04:44:36 -0400
Received: by mail-wr1-f66.google.com with SMTP id j16so4708448wrr.8;
        Tue, 13 Aug 2019 01:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:openpgp:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SDJwnQjuv8+cFv70gCeD4pPzDeWrNoPVh3U04PT4UTo=;
        b=fJtewxdPG91j4ntA6IRwYWaehG/C7ZE1FeBUd+Yf8PiTqWCE2rhuklmiys/EBFkqtX
         UqVrHjsFgRF88ZLDIxUk/PtD8H7MfvWr6RdgPNBa2i/lky+2NeHlvfriIinGYsgEt588
         eypIYoXICelKldnhDzyEy7o9xnhErO0tlhl+sY2DM24LHAkI/3Y0yYvurZP+fb6ZwRLq
         xpYDqMaw37Sa4I4ikaPkNuh7dD+Rv6OpRWPO0T8Jcc+lu9jo80gfzkLQjoseIxIURVNt
         19KxsxM3vXIu5ge12T8A+3/8etiRG2Mux4y6Gw66OTRwTsxgjc648d/VYitBFBZd45T+
         GLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=SDJwnQjuv8+cFv70gCeD4pPzDeWrNoPVh3U04PT4UTo=;
        b=uiVMq87QbfJlI/WZFu51Ma6XF/u1cQst+2E2cj7Y+9eYFijut6AP/zVqWWB2UJn14Y
         +/WCbHo+RZB/WLzxTJU48QCRY5fW+cKLOEpxidRp+vdPkSM58pS4Cmgqs29vtS7cDiHd
         at6GccG8CruWGWaPV7a7DRUm00z19BLzAq/zFw4GfIt0pZwATqoIbqS/gsHHtRmlFTge
         7+N+mE6Hn4wWuHwMFi15i7zKaR6zE9w6XRRttVqGvkaYC0TszJQXgSVZrFH4s91AqpRA
         cTaPJjtarbwqC/FqG7RbII/2bvSMzM8+6g0f4W1xbwQH7aQwk5+lYwk8k5KsFV8SeD2F
         TKDQ==
X-Gm-Message-State: APjAAAWkYGMl0YY+eXaW13BuNi3Bt3g9xlrywA9xgPWe+m7oNrUTOaBC
        E2htPoJ07/s0kPRrDmneb8E=
X-Google-Smtp-Source: APXvYqyh5cs0zBfsrQ9/9b4GlmZJ4f1O1rnDXbQI6CpyecdaWis32Z7KfISDGKCOzITPkf4SiQ85Zg==
X-Received: by 2002:adf:dd88:: with SMTP id x8mr37133406wrl.331.1565685873196;
        Tue, 13 Aug 2019 01:44:33 -0700 (PDT)
Received: from [192.168.1.35] (251.red-88-10-102.dynamicip.rima-tde.net. [88.10.102.251])
        by smtp.gmail.com with ESMTPSA id k124sm1896121wmk.47.2019.08.13.01.44.31
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 01:44:32 -0700 (PDT)
Subject: Re: [PATCH 10/11] mfd: Drop obsolete JZ4740 driver
To:     Lee Jones <lee.jones@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Sebastian Reichel <sre@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, od@zcrc.me,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org,
        Artur Rojek <contact@artur-rojek.eu>
References: <20190725220215.460-1-paul@crapouillou.net>
 <20190725220215.460-11-paul@crapouillou.net> <20190812081640.GA26727@dell>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Openpgp: url=http://pgp.mit.edu/pks/lookup?op=get&search=0xE3E32C2CDEADC0DE
Message-ID: <4b48e597-951e-45fd-dfb2-4a1292a8b067@amsat.org>
Date:   Tue, 13 Aug 2019 10:44:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190812081640.GA26727@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Lee,

On 8/12/19 10:16 AM, Lee Jones wrote:
> On Thu, 25 Jul 2019, Paul Cercueil wrote:
> 
>> It has been replaced with the ingenic-iio driver for the ADC.
>>
>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>> Tested-by: Artur Rojek <contact@artur-rojek.eu>
>> ---
>>  drivers/mfd/Kconfig      |   9 --
>>  drivers/mfd/Makefile     |   1 -
>>  drivers/mfd/jz4740-adc.c | 324 ---------------------------------------
>>  3 files changed, 334 deletions(-)
>>  delete mode 100644 drivers/mfd/jz4740-adc.c
> 
> Applied, thanks.

It seems the replacement is done in "MIPS: qi_lb60: Migrate to
devicetree" which is not yet merged.

Probably easier if this patch goes thru the MIPS tree as part of the
"JZ4740 SoC cleanup" series.

Regards,

Phil.
