Return-Path: <dmaengine+bounces-5882-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9FBB148AA
	for <lists+dmaengine@lfdr.de>; Tue, 29 Jul 2025 08:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D69C717A70A
	for <lists+dmaengine@lfdr.de>; Tue, 29 Jul 2025 06:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09ED826738D;
	Tue, 29 Jul 2025 06:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="26X3Idx1"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26519264627
	for <dmaengine@vger.kernel.org>; Tue, 29 Jul 2025 06:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753771797; cv=none; b=rd5SVVNrlcjMMeyq92nde9jHBWfuOvyl0IjeHQvxXXOZ+NmaeEvdUgP8KXHROWqw8NZSAT3FF/bR1WQVQvj14pUq2ntKAOzSrc95ITiBi4jweB56ea2AGHmBqCtoN8lHwyMMMlEboczEdHNA1lC+a8nAv5wkncsAYXcyk4zOx58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753771797; c=relaxed/simple;
	bh=EOhJI4XE7EmddrlB9TelXwBH+e7RrRI3HJn7pIRR/rk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=XEy6zIEYTGPDFjTSkhQIG6u2yG/0cpGAEwKKPu6YzQZXCCQJBrimItcJ0DDSlOvUj2njsk6BRAHhOCDfXJ/wv6W0WujyOaPVxXC1Nb6BYBgtxUrmY6LchoGMLCpMEZ/hk0ohdwELcqDtMzgFzxiVWICzXFOmxUnR02cJaZB0u5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=26X3Idx1; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-af66d49daffso244905966b.1
        for <dmaengine@vger.kernel.org>; Mon, 28 Jul 2025 23:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1753771792; x=1754376592; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0tvO0qmfUNC2jqa8M7kzzmnccGVoia4ygdONyDNCxVc=;
        b=26X3Idx1BYDQEUjbe/WE12+rsByQkqNFRz9t0mlCCQMZcoOMcqWZUQPITGUIMcjFCT
         kl5I5w2g7pXjhwftBtc7hLyZa8CRpe+QUDlYBvdklu30eZJu2CJTYVHQJIrYSo412gjH
         5HJW8KmTF5XlVXAraB7W3dm/STPlocv5C0W4f/fuDkwq9fdi4B/EN3HwvmUODcqpSVUt
         ScJcdmrKeVrOljbrRC6Y64732dH12RV/cuw3wZ3adkVhU5YuDCmE9CBGuvLP1hIffyzv
         x++sHYcjLcoYCEGOCfwWjjNJjKQQgciew/AsTgBxb1s8gm0ClBaAIAUlth25CWEI+bfe
         TR9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753771792; x=1754376592;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0tvO0qmfUNC2jqa8M7kzzmnccGVoia4ygdONyDNCxVc=;
        b=GafH3jCTL1hK1EZAS96pXUm0BVPIEZBvtgdXhS1edD2KJrfnlavNIFaUup/MO1I+zY
         O9ykYnewqhFDarZfUGOprd/YsTQAY+yJk0kU84XCZpbPjts0oClv5d4s40KjdnOURlR2
         e8EG5E6uW+YYWd0R+TSc1ubSL9OOKMCgPI8LFgKO9ZFrXF74IHIkqdUJF07WYiI+qmuH
         Qhy9TFhEGQNsu0Mm9YrYnKftQAEN5x3rVxr5HoI3mNdhjTqsl0VsoiLHwbtO4OCZom/8
         fSUlGVz3kFKLTRcwR6rJ0bswKYG3OX+1poj4WxmL2Uz+wubn32ntcjaUcALQb7SxUFiJ
         euig==
X-Forwarded-Encrypted: i=1; AJvYcCXhbh7HE8mlxA4E9tZBWG5+Z6IZdn14ISgcuKR41ojOx6WedQeRV2DLPQD8QvgVnrOtByzxCead8nY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxTY+GkkHHu5B/o3/lnZ/LfnYn2gmC30BlUEInKRBE2qa2Cvcu
	1cJn5Oe5RQgKpY+sb58jP5pw/Mjskbyliucbw7CStE5Ko5cwOJNj0J2w797UtmSWRgs=
X-Gm-Gg: ASbGncvy25f6QSW6QEvRcyq4pzkcjtXgWL+MzbvXZdoWkdwSEY6My8ePXTCYRRRlIKn
	8YAUWOMk+au+avtLdoVKYwkVAogtX9TypBRGNnm7dPCiRFEm7ABruSmrcDUWbqh3UJLYbUrG0AE
	X8c+DdptJq9cJXz7Ws8F4k9r9TRRPqpHCf/s0wf7W/2QkezArgP6t5jqG0ixkWIjUlgu5lnOWJm
	kljCSst7IzxC5MQsoB4vxjVLK6PIzCVYgn6PBBOd2eILHRN9cjxIRMwFBAi3pNSkahupTm1EWUx
	z4PE0IVsnJw7rhhuiAOnYrhQ+hIehOdhPEE4VC/1qTDam5tp+CqnA5ZrivwrB/lzHBpDsuJ2CMh
	wvGJxKtePCvQ45v245npeno5vJG1RM/YEUqJsqGVkdtncwmk8q2JKh+k3rCrjQmF4PN8=
X-Google-Smtp-Source: AGHT+IFY1cXRHhDZKmmaOPFoMzRlis7auiB0SY6wze0NFezD/noiXwvsAjKX3xVSDeubNvW/ghlrqg==
X-Received: by 2002:a17:907:868c:b0:ae0:da16:f550 with SMTP id a640c23a62f3a-af619d062b6mr1776275666b.49.1753771792232;
        Mon, 28 Jul 2025 23:49:52 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af6358600b1sm546209366b.7.2025.07.28.23.49.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 23:49:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Jul 2025 08:49:50 +0200
Message-Id: <DBOC7QBND54K.1SI5V9C2Z76BY@fairphone.com>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <dmaengine@vger.kernel.org>,
 <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH v2 14/15] arm64: dts: qcom: Add initial Milos dtsi
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Luca Weiss" <luca.weiss@fairphone.com>, "Konrad Dybcio"
 <konrad.dybcio@oss.qualcomm.com>, "Will Deacon" <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, "Joerg Roedel" <joro@8bytes.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>, "Manivannan
 Sadhasivam" <mani@kernel.org>, "Herbert Xu" <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, "Vinod Koul" <vkoul@kernel.org>,
 "Bjorn Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>, "Robert Marko" <robimarko@gmail.com>, "Das
 Srinagesh" <quic_gurus@quicinc.com>, "Thomas Gleixner"
 <tglx@linutronix.de>, "Jassi Brar" <jassisinghbrar@gmail.com>, "Amit
 Kucheria" <amitk@kernel.org>, "Thara Gopinath" <thara.gopinath@gmail.com>,
 "Daniel Lezcano" <daniel.lezcano@linaro.org>, "Zhang Rui"
 <rui.zhang@intel.com>, "Lukasz Luba" <lukasz.luba@arm.com>, "Ulf Hansson"
 <ulf.hansson@linaro.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
 <20250713-sm7635-fp6-initial-v2-14-e8f9a789505b@fairphone.com>
 <3e0299ad-766a-4876-912e-438fe2cc856d@oss.qualcomm.com>
 <DBE6TK1KDOTP.IIT72I1LUN5M@fairphone.com>
 <DBE8G88CIQ53.2N51CABIBJOOO@fairphone.com>
In-Reply-To: <DBE8G88CIQ53.2N51CABIBJOOO@fairphone.com>

Hi Konrad,

On Thu Jul 17, 2025 at 11:46 AM CEST, Luca Weiss wrote:
> Hi Konrad,
>
> On Thu Jul 17, 2025 at 10:29 AM CEST, Luca Weiss wrote:
>> On Mon Jul 14, 2025 at 1:06 PM CEST, Konrad Dybcio wrote:
>>> On 7/13/25 10:05 AM, Luca Weiss wrote:
>>>> Add a devicetree description for the Milos SoC, which is for example
>>>> Snapdragon 7s Gen 3 (SM7635).
>>>>=20
>>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>>> ---
>>>
>>> [...]
>>>> +
>>>> +		spmi_bus: spmi@c400000 {
>>>> +			compatible =3D "qcom,spmi-pmic-arb";
>>>
>>> There's two bus instances on this platform, check out the x1e binding
>>
>> Will do
>
> One problem: If we make the labels spmi_bus0 and spmi_bus1 then we can't
> reuse the existing PMIC dtsi files since they all reference &spmi_bus.
>
> On FP6 everything's connected to PMIC_SPMI0_*, and PMIC_SPMI1_* is not
> connected to anything so just adding the label spmi_bus on spmi_bus0
> would be fine.
>
> Can I add this to the device dts? Not going to be pretty though...
>
> diff --git a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts b/arch/arm6=
4/boot/dts/qcom/milos-fairphone-fp6.dts
> index d12eaa585b31..69605c9ed344 100644
> --- a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
> +++ b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
> @@ -11,6 +11,9 @@
>  #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>  #include "milos.dtsi"
> +
> +spmi_bus: &spmi_bus0 {};
> +
>  #include "pm7550.dtsi"
>  #include "pm8550vs.dtsi"
>  #include "pmiv0104.dtsi" /* PMIV0108 */
>
> Or I can add a second label for the spmi_bus0 as 'spmi_bus'. Not sure
> other designs than SM7635 recommend using spmi_bus1 for some stuff.
>
> But I guess longer term we'd need to figure out a solution to this, how
> to place a PMIC on a given SPMI bus, if reference designs start to
> recommend putting different PMIC on the separate busses.

Any feedback on this regarding the spmi_bus label?

Regards
Luca

>
> Regards
> Luca


