Return-Path: <dmaengine+bounces-6197-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F47FB347B6
	for <lists+dmaengine@lfdr.de>; Mon, 25 Aug 2025 18:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17B3C177891
	for <lists+dmaengine@lfdr.de>; Mon, 25 Aug 2025 16:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2191A23D2A1;
	Mon, 25 Aug 2025 16:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="1VXKRipO"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99AB301014
	for <dmaengine@vger.kernel.org>; Mon, 25 Aug 2025 16:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756140047; cv=none; b=oQmogdvxH6ALySpoZKYcW5IV2Eh07iZtZi6YqfZgWvXrOkJruI/4/MQHhdCKsdeRguv6+7++4VtMMpemXrQjjaE3vyTD0jlX7bT3R9NGtd1GqpBtamp0PBC1Ls/2tYcrTx4t6zH4uzO5sZAA9QFPZqVkHZ63VsEaB9eF6aoyVjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756140047; c=relaxed/simple;
	bh=4prFTVsDmktsxECVHpJDZoTv8Pciq628dyvSUG8lB50=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=p/EbJiIZhmE23VDqd4cKiWde+B0zKGbHjvAsyJGXmKSOqwBpXQDyPgI8GgOetHLtVKVyxq2iY4sEKEXeNh6jgGQ4teA6CCVScBjRcnkwX6J5OUkW0aw5MGPTaLXaczCi50Q5HQqNP1eXD98PGCQiq1Rh9pHdwalzCKL8LeLciYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=1VXKRipO; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb61f6044so882624766b.0
        for <dmaengine@vger.kernel.org>; Mon, 25 Aug 2025 09:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1756140043; x=1756744843; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FG91uI45uUKeGliVzdh96+GHkDD0Of8ZnOcLCRVdh4U=;
        b=1VXKRipO7WEgLUDn403b2/beI6fZaWvLg1VAh096wZTbkQIXfjWaqNzIwv63eRXjiA
         zTs16GWTffLbmd7NK2kqxb21tT7jkuq2yYjvhKOVVeBfkWq7cUytKpjMDl3FJY5XMHv2
         LwMd4upjxurprqIFcEc7S/Vcv1Be6MaSIMpcDpaldrBeNsSX6W6FpxMBjNjvC85iZBz1
         3wr95KYYCmM9Sw87SQ9+6K2J0fN4v7BIXvEeLujKojJZsCPCHJjjyoLpIsU4uQDQzNWD
         ebdGtQhAvdHB9XimprT/mShlzkikIoHxbtn8KccgJhMum/hxsUuQYakpLT4VimCJ2OIr
         AKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756140043; x=1756744843;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FG91uI45uUKeGliVzdh96+GHkDD0Of8ZnOcLCRVdh4U=;
        b=T4sDgIR72J1QEmHrShHG/LLjlW4Ik9fLYecVNsV+oYaY0ane13Qd9K13r7Gea75RnE
         vYe6Nq0UBcEXQJE+fHPFJN+ApmcWA5liq5McgQ5gG+e961UvQEYihg4zampQOJs/xS8a
         KSalx0oK4basrzCVKYOhpk6LMpoSNv4OA6Ff9kv6oG+jeap1EePsDmjSeRRbl5THyR3Z
         jhLDJaefLzRa25E2dXdPXBGSWFmTZ5wJ6Dvn8p/prOKHZCcMKwr5RIPe09D6h3APo01b
         5f+Kpvf/jA/fN8ghL3pwzXc9FKPf75+o/ZPD1u8y/BuN1hxjQkkqwp4Hrs5Zs/KV/9w6
         d/qQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQmw/qWj+DN7LdGZwTKDnerD7zJNsV+uFMUV11s5Yh4Z8jUrYxw+G/Hu5ilRpbZ108nqCrTjZvvzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzwOle7zTQj7uP5ZB77gPVhmPugLtzHOhcUfojpbD5zhwYqhhT
	ADHrNRzBkxhAf6HQbYcPSkcmz6PVgNGYvOyf8Lfg4480F/YiFTBXMK+/go650xd1coY=
X-Gm-Gg: ASbGncvHwixfyry4VU7P2eQUovXfWNWxcEzQQg6BiMebQJbuRMdGlFsEsq8++aQMkVO
	LO36dMzvC1ffGziCTS+UG+Id679Bykyy3uTtr2M6mCGbISPZlUmHLvelR2iKT/bBzedJTOGylEZ
	z09Dd2UHPxDXHmsr2HIg0ylK54rXAF3DqbAxDa5b9ljINYI5rOi6KsHHW8IIRAhL1ogtLITOuQ3
	kVmThjVIbGKo8uD1F7a1zctYrtTb5UpHyiTp2OPXBU2KkbN2GG8tN3C2+uE+mJXcViKL4Y97enK
	IA38hidD15RY/BVWdK4Qa2xfAd5Dh+odV1pC9ff4+qNygUlvHrI03ycmtiskSDcTTKudUmFcIzP
	sJmQKJ0a4MZw/N2esuAyVN/cY/cqGWsftuk7TwL+460eJbaoFHud7zcYJfAdwoT1JRLw9HE61PE
	GyWB0=
X-Google-Smtp-Source: AGHT+IFV4UU2TtRx1l7OIqQ1JFPaW34gENjDAO9Ve5xixYInhHmsQvVFhIsO1C/Qynf9MIpQCOZJoA==
X-Received: by 2002:a17:907:d8a:b0:afe:6648:a243 with SMTP id a640c23a62f3a-afe9cb1b5e3mr24664366b.3.1756140042823;
        Mon, 25 Aug 2025 09:40:42 -0700 (PDT)
Received: from localhost (83-97-14-181.biz.kpn.net. [83.97.14.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe9c908431sm11361366b.92.2025.08.25.09.40.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 09:40:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 25 Aug 2025 18:40:41 +0200
Message-Id: <DCBNOTQVTDWB.EH08W10NACXL@fairphone.com>
Subject: Re: [PATCH v2 14/15] arm64: dts: qcom: Add initial Milos dtsi
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com>, "Will Deacon"
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
 "Ulf Hansson" <ulf.hansson@linaro.org>,
 <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <dmaengine@vger.kernel.org>,
 <linux-mmc@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
 <20250713-sm7635-fp6-initial-v2-14-e8f9a789505b@fairphone.com>
 <3e0299ad-766a-4876-912e-438fe2cc856d@oss.qualcomm.com>
 <DBE6TK1KDOTP.IIT72I1LUN5M@fairphone.com>
 <DBE8G88CIQ53.2N51CABIBJOOO@fairphone.com>
 <DBOC7QBND54K.1SI5V9C2Z76BY@fairphone.com>
 <55420d89-fcd4-4cb5-a918-d8bbe2a03d19@oss.qualcomm.com>
 <DC74DPI8WS81.17VCYVY34C2F9@fairphone.com>
 <2hv4yuc7rgtglihc2um2lr5ix4dfqxd4abb2bqb445zkhpjpsi@rozikfwrdtlk>
 <DCBMOZQ7BFI9.2B3A3PEZ0DTYD@fairphone.com>
 <2bk7s43nrkmhhgsqq65mxhbmrapyjejyjugnae7wfbttqjmtbf@dk2fe64qrmwx>
In-Reply-To: <2bk7s43nrkmhhgsqq65mxhbmrapyjejyjugnae7wfbttqjmtbf@dk2fe64qrmwx>

On Mon Aug 25, 2025 at 6:36 PM CEST, Dmitry Baryshkov wrote:
> On Mon, Aug 25, 2025 at 05:53:53PM +0200, Luca Weiss wrote:
>> Hi Dmitry,
>>=20
>> On Wed Aug 20, 2025 at 1:52 PM CEST, Dmitry Baryshkov wrote:
>> > On Wed, Aug 20, 2025 at 10:42:09AM +0200, Luca Weiss wrote:
>> >> Hi Konrad,
>> >>=20
>> >> On Sat Aug 2, 2025 at 2:04 PM CEST, Konrad Dybcio wrote:
>> >> > On 7/29/25 8:49 AM, Luca Weiss wrote:
>> >> >> Hi Konrad,
>> >> >>=20
>> >> >> On Thu Jul 17, 2025 at 11:46 AM CEST, Luca Weiss wrote:
>> >> >>> Hi Konrad,
>> >> >>>
>> >> >>> On Thu Jul 17, 2025 at 10:29 AM CEST, Luca Weiss wrote:
>> >> >>>> On Mon Jul 14, 2025 at 1:06 PM CEST, Konrad Dybcio wrote:
>> >> >>>>> On 7/13/25 10:05 AM, Luca Weiss wrote:
>> >> >>>>>> Add a devicetree description for the Milos SoC, which is for e=
xample
>> >> >>>>>> Snapdragon 7s Gen 3 (SM7635).
>> >> >>>>>>
>> >> >>>>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> >> >>>>>> ---
>> >> >>>>>
>> >> >>>>> [...]
>> >> >>>>>> +
>> >> >>>>>> +		spmi_bus: spmi@c400000 {
>> >> >>>>>> +			compatible =3D "qcom,spmi-pmic-arb";
>> >> >>>>>
>> >> >>>>> There's two bus instances on this platform, check out the x1e b=
inding
>> >> >>>>
>> >> >>>> Will do
>> >> >>>
>> >> >>> One problem: If we make the labels spmi_bus0 and spmi_bus1 then w=
e can't
>> >> >>> reuse the existing PMIC dtsi files since they all reference &spmi=
_bus.
>> >> >>>
>> >> >>> On FP6 everything's connected to PMIC_SPMI0_*, and PMIC_SPMI1_* i=
s not
>> >> >>> connected to anything so just adding the label spmi_bus on spmi_b=
us0
>> >> >>> would be fine.
>> >> >>>
>> >> >>> Can I add this to the device dts? Not going to be pretty though..=
.
>> >> >>>
>> >> >>> diff --git a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts b/a=
rch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
>> >> >>> index d12eaa585b31..69605c9ed344 100644
>> >> >>> --- a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
>> >> >>> +++ b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
>> >> >>> @@ -11,6 +11,9 @@
>> >> >>>  #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>> >> >>>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>> >> >>>  #include "milos.dtsi"
>> >> >>> +
>> >> >>> +spmi_bus: &spmi_bus0 {};
>> >> >>> +
>> >> >>>  #include "pm7550.dtsi"
>> >> >>>  #include "pm8550vs.dtsi"
>> >> >>>  #include "pmiv0104.dtsi" /* PMIV0108 */
>> >> >>>
>> >> >>> Or I can add a second label for the spmi_bus0 as 'spmi_bus'. Not =
sure
>> >> >>> other designs than SM7635 recommend using spmi_bus1 for some stuf=
f.
>> >> >>>
>> >> >>> But I guess longer term we'd need to figure out a solution to thi=
s, how
>> >> >>> to place a PMIC on a given SPMI bus, if reference designs start t=
o
>> >> >>> recommend putting different PMIC on the separate busses.
>> >> >>=20
>> >> >> Any feedback on this regarding the spmi_bus label?
>> >> >
>> >> > I had an offline chat with Bjorn and we only came up with janky
>> >> > solutions :)
>> >> >
>> >> > What you propose works well if the PMICs are all on bus0, which is
>> >> > not the case for the newest platforms. If some instances are on bus=
0
>> >> > and others are on bus1, things get ugly really quick and we're goin=
g
>> >> > to drown in #ifdefs.
>> >> >
>> >> >
>> >> > An alternative that I've seen downstream is to define PMIC nodes in
>> >> > the root of a dtsi file (not in the root of DT, i.e. NOT under / { =
})
>> >> > and do the following:
>> >> >
>> >> > &spmi_busN {
>> >> > 	#include "pmABCDX.dtsi"
>> >> > };
>> >> >
>> >> > Which is "okay", but has the visible downside of having to define t=
he
>> >> > temp alarm thermal zone in each board's DT separately (and doing
>> >> > mid-file includes which is.. fine I guess, but also something we av=
oided
>> >> > upstream for the longest time)
>> >> >
>> >> >
>> >> > Both are less than ideal when it comes to altering the SID under
>> >> > "interrupts", fixing that would help immensely. We were hoping to
>> >> > leverage something like Johan's work on drivers/mfd/qcom-pm8008.c,
>> >> > but that seems like a longer term project.
>> >> >
>> >> > Please voice your opinions
>> >>=20
>> >> Since nobody else jumped in, how can we continue?
>> >>=20
>> >> One janky solution in my mind is somewhat similar to the PMxxxx_SID
>> >> defines, doing something like "#define PM7550_SPMI spmi_bus0" and the=
n
>> >> using "&PM7550_SPMI {}" in the dtsi. I didn't try it so not sure that
>> >> actually works but something like this should I imagine.
>> >>=20
>> >> But fortunately my Milos device doesn't have the problem that it
>> >> actually uses both SPMI busses for different PMICs, so similar to oth=
er
>> >> SoCs that already have two SPMI busses, I could somewhat ignore the
>> >> problem and let someone else figure out how to actually place PMICs o=
n
>> >> spmi_bus0 and spmi_bus1 if they have such a hardware.
>> >
>> > I'd say, ignore it for now.
>>=20
>> You mean ignoring that there's a second SPMI bus on this SoC, and just
>> modelling one with the label "spmi_bus"? Or something else?
>>=20
>>=20
>> I have also actually tried out the C define solution that I was writing
>> about in my previous email and this is actually working, see diff below.
>> In my opinion it just expands on what we have with the SID defines, so
>> shouldn't be tooo unacceptable :)
>
> I think we tried previously using C preprocessor to rework SID handling
> and it wasn't accepted by DT maintainers.

I don't know anything about that, but yeah...

>
> I'd say, ignore the second bus for now, unless it gets actually used for
> major PMICs.

The only 'problem' with this is once we do figure out a solution, the
SoC bindings will change, so both dt-bindings and dtsi needs to be
updated. But that's the case also for sm8550 and friends that currently
ignore the second SPMI bus upstream.

On FP6 again, it's definitely not a problem since everything's just on
the first SPMI bus anyways.

So then I'll revert the change to compatible =3D "qcom,milos-spmi-pmic-arb"=
, "qcom,x1e80100-spmi-pmic-arb";
plus associated subnodes for the next revision.

Regards
Luca

