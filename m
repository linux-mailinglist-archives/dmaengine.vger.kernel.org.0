Return-Path: <dmaengine+bounces-6195-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29EA3B34660
	for <lists+dmaengine@lfdr.de>; Mon, 25 Aug 2025 17:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F10EA2A44A0
	for <lists+dmaengine@lfdr.de>; Mon, 25 Aug 2025 15:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD112FDC22;
	Mon, 25 Aug 2025 15:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="o0SLw+wP"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A959F2FF143
	for <dmaengine@vger.kernel.org>; Mon, 25 Aug 2025 15:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756137240; cv=none; b=TVbGFZj4jjibygKBTCqGBHhZegun8eKS25v+XzQZFLhi5X48yANrEqe0m1jh3oqXUUUxUgkBdwjCHWCH+s7s3ooRNZElQQMFIx0bOAxMiVGlCDV+Wm33InIonA8plIBsUv1/k5apF32Fjrx/9FUA1kmH3NPMMVVNcBq0j8ypqb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756137240; c=relaxed/simple;
	bh=iDIMFaPmP6Ptap4BSySC5MxVV+P3d+K2pyIekorzzbo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=KAEUrnVlTBKq2a98GgpR7G8EPapBevwVqMUBmTsJEDuBiJw99rtnUi+ryV560/0yEMB2/qZpDFP5jibl+oAO13ejwB2bgb2tunOzsEJY6j4tfZtkCAQ4mkWxM9YL9unzG4PxhzJb1mf3sLAFFBv9Gmgzn9v+BepK9Wn20AlkaD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=o0SLw+wP; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb78e70c5so716993566b.1
        for <dmaengine@vger.kernel.org>; Mon, 25 Aug 2025 08:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1756137235; x=1756742035; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3HqowhwKhilGiIPsPTFLVOfvfqilXqLVrLNuX0vYRl8=;
        b=o0SLw+wPAtkVA9cVDuec/zje+HDAOCIO1NrveoFG195mCQpM9erUKFUZ81uhSvlFpc
         Laf8qKGtVqBxXsfR3AVXuDf+XXB2xusNPIG5W26KP/xcmtRxpMZ1ic6TshUJTdFiKa/A
         UwHIIATPuxcsf/hFud1Z4Z/TzB711ipM1B3Z+1wQGu3Y9/Pa9rL1uscKEzAw0vzqLrkF
         cc3N82hq+7MmmdWhoYaWm9MK/Q3qt/vbvSdtpoddAaBuaWwye3ai6EDx7mJaMZ3ghHgG
         EzKPBQTTfMgsLWkmONelIVDpKX5rLH5OFUHvw8Cm1S9TycB/EtLvevHkjEyD/ST1iMw+
         DHLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756137235; x=1756742035;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3HqowhwKhilGiIPsPTFLVOfvfqilXqLVrLNuX0vYRl8=;
        b=tQdA/++I4IvEPLeJSaW7Pm/mHLwZ/QzeXLOOGq2PiHYp6+0Fp2W4zwnFu9KBWjZzM7
         tHVLvjPup6owVvs+OWa3TSOtQYHJF2wvSMyNKMSMOZE1FK+sCbaSk9xs59k2lLLIAuY3
         HC/fRa0Q1kpyWb4G60muK0a64uKK6RFDiDV7OdzqiZxlb2qNrO/4DwsirQ/bVboEuojC
         zd7V0HaB1OKYzd1fVD5od0wVBkaUb52wxKQsFdmSQj2vV4KmNduszlzK1ppT8nTfCvKp
         vhyja9xOHAA7WmW1swBPVzLV5ZRy9Q6oOhu5GQeJbnOwNhjC1ND8cZxdH2Y6BDWCXtVd
         2Tbw==
X-Forwarded-Encrypted: i=1; AJvYcCWQ8wkpntpIhX0ys0xBBYZPmIOmACr4cYuZR/UCPwAxvPr+jRzghqfXeG1+XrEd+pGfOg4tKdbkIfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvT3q0QuY5mRtwqhN0ulWgak7U3eabLZ3ppMHecEb5HPl9XQB/
	0lzjE9bvdI8HORyVhTJIbqRPGdco47AYCEWrp1a0Ddt46effSbQgGBjTWodkhX+GQoY=
X-Gm-Gg: ASbGncsXa3tJ1lSTjqKKw+FU/1VRVmHQZrT9T9WPytudr7PF1AzNPCZ6zBdfKgRoBY1
	eA/mHlg30Ij/FtKhDVmtjspfJCS7Whc1+UWqZRRLfeFQl20/crYz7BWtmHL1SjUIQ8dbLFgzpWQ
	GbwDQ+dxUj24Jfw4TeZK7o1F7PAZEHXz/tpD5NkGBfVjmoTrYfEKI3neXWUkUs2OZq+/wCDaJE3
	MTQ219BCyD3zMCB107LLQ94AwBX6mIRaORMpUwRnyKmQFHaWqhl7EH3DMnOJDFIHobr4uAwma/h
	5Elvrmq2xGu04pGmgh93RjLlFRViKDep1l6PizX8+0tZo6yhcUCw1uqZ7rmZBFS9IGWIr6BnYIQ
	jZpyEIdwjH4R1EN6a3MDAtHZ3R4ynLfClzjkka73IFsy9n27gVz6vUrUdOjXbRZtiBObTV5KApC
	GyMTs=
X-Google-Smtp-Source: AGHT+IEDOv6gprEj6Ksbmo7p57Z4tZTNEHhZ9DTRLeOqT0HCwoH6lmCXLeF8Wklr2ttI5zxfbuX7Eg==
X-Received: by 2002:a17:906:7943:b0:ae3:b2b7:7f2f with SMTP id a640c23a62f3a-afe296e74c2mr1283531066b.40.1756137234813;
        Mon, 25 Aug 2025 08:53:54 -0700 (PDT)
Received: from localhost (83-97-14-181.biz.kpn.net. [83.97.14.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe8b5fbc8dsm139360466b.1.2025.08.25.08.53.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 08:53:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 25 Aug 2025 17:53:53 +0200
Message-Id: <DCBMOZQ7BFI9.2B3A3PEZ0DTYD@fairphone.com>
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
Subject: Re: [PATCH v2 14/15] arm64: dts: qcom: Add initial Milos dtsi
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
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
In-Reply-To: <2hv4yuc7rgtglihc2um2lr5ix4dfqxd4abb2bqb445zkhpjpsi@rozikfwrdtlk>

Hi Dmitry,

On Wed Aug 20, 2025 at 1:52 PM CEST, Dmitry Baryshkov wrote:
> On Wed, Aug 20, 2025 at 10:42:09AM +0200, Luca Weiss wrote:
>> Hi Konrad,
>>=20
>> On Sat Aug 2, 2025 at 2:04 PM CEST, Konrad Dybcio wrote:
>> > On 7/29/25 8:49 AM, Luca Weiss wrote:
>> >> Hi Konrad,
>> >>=20
>> >> On Thu Jul 17, 2025 at 11:46 AM CEST, Luca Weiss wrote:
>> >>> Hi Konrad,
>> >>>
>> >>> On Thu Jul 17, 2025 at 10:29 AM CEST, Luca Weiss wrote:
>> >>>> On Mon Jul 14, 2025 at 1:06 PM CEST, Konrad Dybcio wrote:
>> >>>>> On 7/13/25 10:05 AM, Luca Weiss wrote:
>> >>>>>> Add a devicetree description for the Milos SoC, which is for exam=
ple
>> >>>>>> Snapdragon 7s Gen 3 (SM7635).
>> >>>>>>
>> >>>>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> >>>>>> ---
>> >>>>>
>> >>>>> [...]
>> >>>>>> +
>> >>>>>> +		spmi_bus: spmi@c400000 {
>> >>>>>> +			compatible =3D "qcom,spmi-pmic-arb";
>> >>>>>
>> >>>>> There's two bus instances on this platform, check out the x1e bind=
ing
>> >>>>
>> >>>> Will do
>> >>>
>> >>> One problem: If we make the labels spmi_bus0 and spmi_bus1 then we c=
an't
>> >>> reuse the existing PMIC dtsi files since they all reference &spmi_bu=
s.
>> >>>
>> >>> On FP6 everything's connected to PMIC_SPMI0_*, and PMIC_SPMI1_* is n=
ot
>> >>> connected to anything so just adding the label spmi_bus on spmi_bus0
>> >>> would be fine.
>> >>>
>> >>> Can I add this to the device dts? Not going to be pretty though...
>> >>>
>> >>> diff --git a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts b/arch=
/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
>> >>> index d12eaa585b31..69605c9ed344 100644
>> >>> --- a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
>> >>> +++ b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
>> >>> @@ -11,6 +11,9 @@
>> >>>  #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>> >>>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>> >>>  #include "milos.dtsi"
>> >>> +
>> >>> +spmi_bus: &spmi_bus0 {};
>> >>> +
>> >>>  #include "pm7550.dtsi"
>> >>>  #include "pm8550vs.dtsi"
>> >>>  #include "pmiv0104.dtsi" /* PMIV0108 */
>> >>>
>> >>> Or I can add a second label for the spmi_bus0 as 'spmi_bus'. Not sur=
e
>> >>> other designs than SM7635 recommend using spmi_bus1 for some stuff.
>> >>>
>> >>> But I guess longer term we'd need to figure out a solution to this, =
how
>> >>> to place a PMIC on a given SPMI bus, if reference designs start to
>> >>> recommend putting different PMIC on the separate busses.
>> >>=20
>> >> Any feedback on this regarding the spmi_bus label?
>> >
>> > I had an offline chat with Bjorn and we only came up with janky
>> > solutions :)
>> >
>> > What you propose works well if the PMICs are all on bus0, which is
>> > not the case for the newest platforms. If some instances are on bus0
>> > and others are on bus1, things get ugly really quick and we're going
>> > to drown in #ifdefs.
>> >
>> >
>> > An alternative that I've seen downstream is to define PMIC nodes in
>> > the root of a dtsi file (not in the root of DT, i.e. NOT under / { })
>> > and do the following:
>> >
>> > &spmi_busN {
>> > 	#include "pmABCDX.dtsi"
>> > };
>> >
>> > Which is "okay", but has the visible downside of having to define the
>> > temp alarm thermal zone in each board's DT separately (and doing
>> > mid-file includes which is.. fine I guess, but also something we avoid=
ed
>> > upstream for the longest time)
>> >
>> >
>> > Both are less than ideal when it comes to altering the SID under
>> > "interrupts", fixing that would help immensely. We were hoping to
>> > leverage something like Johan's work on drivers/mfd/qcom-pm8008.c,
>> > but that seems like a longer term project.
>> >
>> > Please voice your opinions
>>=20
>> Since nobody else jumped in, how can we continue?
>>=20
>> One janky solution in my mind is somewhat similar to the PMxxxx_SID
>> defines, doing something like "#define PM7550_SPMI spmi_bus0" and then
>> using "&PM7550_SPMI {}" in the dtsi. I didn't try it so not sure that
>> actually works but something like this should I imagine.
>>=20
>> But fortunately my Milos device doesn't have the problem that it
>> actually uses both SPMI busses for different PMICs, so similar to other
>> SoCs that already have two SPMI busses, I could somewhat ignore the
>> problem and let someone else figure out how to actually place PMICs on
>> spmi_bus0 and spmi_bus1 if they have such a hardware.
>
> I'd say, ignore it for now.

You mean ignoring that there's a second SPMI bus on this SoC, and just
modelling one with the label "spmi_bus"? Or something else?


I have also actually tried out the C define solution that I was writing
about in my previous email and this is actually working, see diff below.
In my opinion it just expands on what we have with the SID defines, so
shouldn't be tooo unacceptable :)

diff --git a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts b/arch/arm64/=
boot/dts/qcom/milos-fairphone-fp6.dts
index 9fb174592e2d..96e1b5df4f65 100644
--- a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
+++ b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
@@ -7,6 +7,12 @@
=20
 #define PMIV0104_SID 7
=20
+#define PM7550_SPMI spmi_bus0
+#define PM8550VS_SPMI spmi_bus0
+#define PMIV0104_SPMI spmi_bus0
+#define PMK8550_SPMI spmi_bus0
+#define PMR735B_SPMI spmi_bus0
+
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
diff --git a/arch/arm64/boot/dts/qcom/pm7550.dtsi b/arch/arm64/boot/dts/qco=
m/pm7550.dtsi
index b886c2397fe7..08d7969128c2 100644
--- a/arch/arm64/boot/dts/qcom/pm7550.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm7550.dtsi
@@ -34,7 +34,7 @@ trip1 {
 	};
 };
=20
-&spmi_bus {
+&PM7550_SPMI {
 	pm7550: pmic@1 {
 		compatible =3D "qcom,pm7550", "qcom,spmi-pmic";
 		reg =3D <0x1 SPMI_USID>;
diff --git a/arch/arm64/boot/dts/qcom/pm8550vs.dtsi b/arch/arm64/boot/dts/q=
com/pm8550vs.dtsi
index 7b5898c263ad..3c8c5f3724a2 100644
--- a/arch/arm64/boot/dts/qcom/pm8550vs.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8550vs.dtsi
@@ -91,7 +91,7 @@ trip1 {
 };
=20
=20
-&spmi_bus {
+&PM8550VS_SPMI {
 	pm8550vs_c: pmic@2 {
 		compatible =3D "qcom,pm8550", "qcom,spmi-pmic";
 		reg =3D <0x2 SPMI_USID>;
diff --git a/arch/arm64/boot/dts/qcom/pmiv0104.dtsi b/arch/arm64/boot/dts/q=
com/pmiv0104.dtsi
index 85ee8911d93e..bf0c02974e74 100644
--- a/arch/arm64/boot/dts/qcom/pmiv0104.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmiv0104.dtsi
@@ -40,7 +40,7 @@ trip2 {
 	};
 };
=20
-&spmi_bus {
+&PMIV0104_SPMI {
 	pmic@PMIV0104_SID {
 		compatible =3D "qcom,pmiv0104", "qcom,spmi-pmic";
 		reg =3D <PMIV0104_SID SPMI_USID>;
diff --git a/arch/arm64/boot/dts/qcom/pmk8550.dtsi b/arch/arm64/boot/dts/qc=
om/pmk8550.dtsi
index 583f61fc16ad..f1c34f0a2522 100644
--- a/arch/arm64/boot/dts/qcom/pmk8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmk8550.dtsi
@@ -18,7 +18,7 @@ reboot-mode {
 	};
 };
=20
-&spmi_bus {
+&PMK8550_SPMI {
 	pmk8550: pmic@0 {
 		compatible =3D "qcom,pm8550", "qcom,spmi-pmic";
 		reg =3D <0x0 SPMI_USID>;
diff --git a/arch/arm64/boot/dts/qcom/pmr735b.dtsi b/arch/arm64/boot/dts/qc=
om/pmr735b.dtsi
index 09affc05b397..91b53348a4ae 100644
--- a/arch/arm64/boot/dts/qcom/pmr735b.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmr735b.dtsi
@@ -30,7 +30,7 @@ pmr735b_crit: pmr735a-crit {
 	};
 };
=20
-&spmi_bus {
+&PMR735B_SPMI {
 	pmr735b: pmic@5 {
 		compatible =3D "qcom,pmr735b", "qcom,spmi-pmic";
 		reg =3D <0x5 SPMI_USID>;

