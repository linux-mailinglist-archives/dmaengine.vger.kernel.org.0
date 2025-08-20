Return-Path: <dmaengine+bounces-6077-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC31FB2D6F0
	for <lists+dmaengine@lfdr.de>; Wed, 20 Aug 2025 10:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E17D6188B116
	for <lists+dmaengine@lfdr.de>; Wed, 20 Aug 2025 08:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43692D94B7;
	Wed, 20 Aug 2025 08:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="Hisoo03y"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9892D8789
	for <dmaengine@vger.kernel.org>; Wed, 20 Aug 2025 08:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755679334; cv=none; b=kUegL5APA5lY9f0OICKlLXKsgLm8ijQoF3cAVfPe1FB0zkQK1X9qAAJ6PU0sot5/5zNtOWS9mAfnH8h2gt8jdHq0LdRBI1v959oet5f7k+VZs0esWdj2tj2kgU+cZO7uq8MVK33nvnIbK1M/WbQVCThnWl+D6FOlf+yYasitw6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755679334; c=relaxed/simple;
	bh=zMxp/Y9NCrKDYrER4UyjAnXSn/8lzKPXQ7dHBNQTR30=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=hKUJ8iI1IkbXJe3HTv8zunNrxyBRMWya7/hImtAGcx+q3WMFf+5PBG+Yi4cC+KMI6c9J57jo/C4GtbPmiCpbGB0k7idTAShKbgVRxgBRPE1E8Icg5M9KqBpbkuXs6vffLqrtMkNFPgciXSAcuO1w9zW+Ui6jiJwi7MHLWB4jBEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=Hisoo03y; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb7a3b3a9so877275466b.2
        for <dmaengine@vger.kernel.org>; Wed, 20 Aug 2025 01:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1755679331; x=1756284131; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dETmxzysQAIIrfvzFS6NhiwZKV/rguUqMxZ2Lb2+BiA=;
        b=Hisoo03y9XPP464yOPXxVjUqj3dwzI25SNF2mh3om6L87mrSL1I5xseXAIYxPdKBah
         5RqXOfK2i5/qLPMiB3BIezAA8BW/FUitmmeBZP78Dg3zLQjnW2GR0pUgZxyLiLSK4ho5
         KLWWPPZgeSLCeMf6xUAFwNxBx1V8PnUuBTBN4lYlDw9mkWmOiBlLczleThtGSBjWw34N
         fkg2BAGdIr7YwKWut46Nc3C/lF1izmKhSjonPW7/CMlGok0JJs4zmNezrp82BIkgayOe
         Fhva+a1ixV6qGtSHTwapA54vX9olPxwaqCYBLVTXwaHGYP09zOkRBg6etgFL1C5+SiuC
         +WgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755679331; x=1756284131;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dETmxzysQAIIrfvzFS6NhiwZKV/rguUqMxZ2Lb2+BiA=;
        b=SSXRFF66OXPW/7UooA/UCe8z+8XGXTWFevcG3VfwPJQN1ETLY6QbEfcI/P2sxrtqyQ
         abFzgjGFgLtzrn7Z2NYz6C8pI7IbqnO7dXc9FSgc76mRsXQfsqkhTpf2YTI5uF9uhC9u
         D5h45szmat1L1TaLaOdUpP0Q6VQ5Nqnp2NZVqjCtNfKLrpd4urcOW10ujg4T/2UXTJ+O
         sPgIESSUuW2+n4SaXhTdEDAxxjZdRCuv6MpCfuXEicJPVYmzhUiCPVgqTLp47x/kcP+l
         gg1oMDrintpiPtWxuzf6rsellHlkZu9N99NEdDuUbHuv4CB6tykh5lDfXu3maM74aPRh
         2Egg==
X-Forwarded-Encrypted: i=1; AJvYcCW1ooZ2B6ULwIYBzlBiJ+inMWZ2W1lvOR7E8ay6/QM3u+fpd6bCm4MKdYr31vL7xs6dWqCxJ3yQf9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJi9qVMhVw0rqcvUtYy1+9e74JP3iUzdnh/vJMZOjUgwoZ4NtC
	goWJIeZPrqJhzum4ju46E1ZvoAipGL/m5QdYwIwDtURbvKHj5bENHQZkQK7+pDrujrY=
X-Gm-Gg: ASbGncsbO+EyFbSBfYPFremQD5Oj4XCA/ZYKC6J+U4KpVmPSoDfhUvOG9YqEFnw0hgv
	skcr56YZ4kj+0sCNkBdK/3NaPG9Xnkr3VPg/VHyN6RBisu6z7f7mmKPKNEO9BbmR3ZjxBbM3DSP
	FksruZ7HBARD7f6KBuVNwVpaf7ybm1IjW+5D/Xi3Y41EHhZecrcjOjqqhul4k3C2if1Ll9CvwrM
	yc0lJSfavrNEnvIOkpjVJDQbv6q0TXHoinInz1N/gTEjBx2yU8UyThYV9S3jCby7e/6eymUFHJI
	wmsq/y+TT3BQN089j8lhLhV0R0+2m6DneoFlyFE0brHEG4zsMahWj/47DwX925cDaMV9PI7Bqmy
	pNDX4b4c0SqqJJz77tL7Q/13+wMaffrKTbYGrG+AU2YwYsZ06hetjiy8KTgalnafAQX0=
X-Google-Smtp-Source: AGHT+IEac2OEaqE2OoGnweWa6iOptxoUoAiXM3h5Vw1WEpE7VDgBBgHTZqHGUTgnoBZuEdKM1TFNmg==
X-Received: by 2002:a17:907:9715:b0:ae3:6f35:36fe with SMTP id a640c23a62f3a-afdf01e915cmr146724366b.47.1755679330638;
        Wed, 20 Aug 2025 01:42:10 -0700 (PDT)
Received: from localhost (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded478bf3sm138377366b.53.2025.08.20.01.42.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 01:42:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 Aug 2025 10:42:09 +0200
Message-Id: <DC74DPI8WS81.17VCYVY34C2F9@fairphone.com>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <dmaengine@vger.kernel.org>,
 <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH v2 14/15] arm64: dts: qcom: Add initial Milos dtsi
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com>, "Will Deacon"
 <will@kernel.org>, "Robin Murphy" <robin.murphy@arm.com>, "Joerg Roedel"
 <joro@8bytes.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>,
 "Manivannan Sadhasivam" <mani@kernel.org>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
 "Vinod Koul" <vkoul@kernel.org>, "Bjorn Andersson" <andersson@kernel.org>,
 "Konrad Dybcio" <konradybcio@kernel.org>, "Robert Marko"
 <robimarko@gmail.com>, "Das Srinagesh" <quic_gurus@quicinc.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, "Jassi Brar" <jassisinghbrar@gmail.com>,
 "Amit Kucheria" <amitk@kernel.org>, "Thara Gopinath"
 <thara.gopinath@gmail.com>, "Daniel Lezcano" <daniel.lezcano@linaro.org>,
 "Zhang Rui" <rui.zhang@intel.com>, "Lukasz Luba" <lukasz.luba@arm.com>,
 "Ulf Hansson" <ulf.hansson@linaro.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
 <20250713-sm7635-fp6-initial-v2-14-e8f9a789505b@fairphone.com>
 <3e0299ad-766a-4876-912e-438fe2cc856d@oss.qualcomm.com>
 <DBE6TK1KDOTP.IIT72I1LUN5M@fairphone.com>
 <DBE8G88CIQ53.2N51CABIBJOOO@fairphone.com>
 <DBOC7QBND54K.1SI5V9C2Z76BY@fairphone.com>
 <55420d89-fcd4-4cb5-a918-d8bbe2a03d19@oss.qualcomm.com>
In-Reply-To: <55420d89-fcd4-4cb5-a918-d8bbe2a03d19@oss.qualcomm.com>

Hi Konrad,

On Sat Aug 2, 2025 at 2:04 PM CEST, Konrad Dybcio wrote:
> On 7/29/25 8:49 AM, Luca Weiss wrote:
>> Hi Konrad,
>>=20
>> On Thu Jul 17, 2025 at 11:46 AM CEST, Luca Weiss wrote:
>>> Hi Konrad,
>>>
>>> On Thu Jul 17, 2025 at 10:29 AM CEST, Luca Weiss wrote:
>>>> On Mon Jul 14, 2025 at 1:06 PM CEST, Konrad Dybcio wrote:
>>>>> On 7/13/25 10:05 AM, Luca Weiss wrote:
>>>>>> Add a devicetree description for the Milos SoC, which is for example
>>>>>> Snapdragon 7s Gen 3 (SM7635).
>>>>>>
>>>>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>>>>> ---
>>>>>
>>>>> [...]
>>>>>> +
>>>>>> +		spmi_bus: spmi@c400000 {
>>>>>> +			compatible =3D "qcom,spmi-pmic-arb";
>>>>>
>>>>> There's two bus instances on this platform, check out the x1e binding
>>>>
>>>> Will do
>>>
>>> One problem: If we make the labels spmi_bus0 and spmi_bus1 then we can'=
t
>>> reuse the existing PMIC dtsi files since they all reference &spmi_bus.
>>>
>>> On FP6 everything's connected to PMIC_SPMI0_*, and PMIC_SPMI1_* is not
>>> connected to anything so just adding the label spmi_bus on spmi_bus0
>>> would be fine.
>>>
>>> Can I add this to the device dts? Not going to be pretty though...
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts b/arch/ar=
m64/boot/dts/qcom/milos-fairphone-fp6.dts
>>> index d12eaa585b31..69605c9ed344 100644
>>> --- a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
>>> +++ b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
>>> @@ -11,6 +11,9 @@
>>>  #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>>>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>>>  #include "milos.dtsi"
>>> +
>>> +spmi_bus: &spmi_bus0 {};
>>> +
>>>  #include "pm7550.dtsi"
>>>  #include "pm8550vs.dtsi"
>>>  #include "pmiv0104.dtsi" /* PMIV0108 */
>>>
>>> Or I can add a second label for the spmi_bus0 as 'spmi_bus'. Not sure
>>> other designs than SM7635 recommend using spmi_bus1 for some stuff.
>>>
>>> But I guess longer term we'd need to figure out a solution to this, how
>>> to place a PMIC on a given SPMI bus, if reference designs start to
>>> recommend putting different PMIC on the separate busses.
>>=20
>> Any feedback on this regarding the spmi_bus label?
>
> I had an offline chat with Bjorn and we only came up with janky
> solutions :)
>
> What you propose works well if the PMICs are all on bus0, which is
> not the case for the newest platforms. If some instances are on bus0
> and others are on bus1, things get ugly really quick and we're going
> to drown in #ifdefs.
>
>
> An alternative that I've seen downstream is to define PMIC nodes in
> the root of a dtsi file (not in the root of DT, i.e. NOT under / { })
> and do the following:
>
> &spmi_busN {
> 	#include "pmABCDX.dtsi"
> };
>
> Which is "okay", but has the visible downside of having to define the
> temp alarm thermal zone in each board's DT separately (and doing
> mid-file includes which is.. fine I guess, but also something we avoided
> upstream for the longest time)
>
>
> Both are less than ideal when it comes to altering the SID under
> "interrupts", fixing that would help immensely. We were hoping to
> leverage something like Johan's work on drivers/mfd/qcom-pm8008.c,
> but that seems like a longer term project.
>
> Please voice your opinions

Since nobody else jumped in, how can we continue?

One janky solution in my mind is somewhat similar to the PMxxxx_SID
defines, doing something like "#define PM7550_SPMI spmi_bus0" and then
using "&PM7550_SPMI {}" in the dtsi. I didn't try it so not sure that
actually works but something like this should I imagine.

But fortunately my Milos device doesn't have the problem that it
actually uses both SPMI busses for different PMICs, so similar to other
SoCs that already have two SPMI busses, I could somewhat ignore the
problem and let someone else figure out how to actually place PMICs on
spmi_bus0 and spmi_bus1 if they have such a hardware.

Regards
Luca

>
> Konrad


