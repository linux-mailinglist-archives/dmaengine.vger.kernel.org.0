Return-Path: <dmaengine+bounces-8049-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B360FCF774E
	for <lists+dmaengine@lfdr.de>; Tue, 06 Jan 2026 10:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B36730D186C
	for <lists+dmaengine@lfdr.de>; Tue,  6 Jan 2026 09:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A545F30C60E;
	Tue,  6 Jan 2026 09:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U1bI6WlT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vc+zioEk"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB092D9ECB
	for <dmaengine@vger.kernel.org>; Tue,  6 Jan 2026 09:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767690930; cv=none; b=qnhoszawkyTNdp0Gmb+9RNfTs8VkJGke9MO8QqLWny8jWGADpKieVECT4gPJAQiQBdV1wSjmOhvjvE6zbX+QRYPDKYfBCHzwn0h5ZbXq5CqK3ZYlODjd+e37cycE/nWTwW2W7JBmgv2DaLCyDoy1Y3BWZzeNLw1FEpvpLah9z1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767690930; c=relaxed/simple;
	bh=yRljZXW19bL9W7HE6hwL7lUsKYJt+g5uw13tOylCf70=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hZGQDQfAEmk7cRCSljn4X7JkCMUGZSGuqAQEwnwyggHsVMPy7/o9IUQN5e0FWNjevZCmHi0uU4Dz52CsXxo8xMlzNmkbM0o8iNEotq1+0QMjxnyHZhV3khqa85slLumNAmME2LPzqHGDYRU6gsxs/L2oYTM54kEdSo4dyqckwMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U1bI6WlT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Vc+zioEk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6063QLs12922820
	for <dmaengine@vger.kernel.org>; Tue, 6 Jan 2026 09:15:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=kSJ/eEbuN5yGHUMen9nJkB
	t0F9uVUPS6BNRUD76mvkI=; b=U1bI6WlTVDkpZM8Qhi/PtbYOEir+Rliawjr70l
	3tCpWrNpmA7Fqyn2fatvQsPJnKU3NTLpSOBFexHe7usoAbJs7zcjvxyNhkGjk4vQ
	T7LwPzSdfhTKaFPtZGyEzNbOBqX6zri7+JowmrKoNseH7B+336enRv8QjwbDEBKz
	k+LWUBRcrHU1mDfPLQxYePM6VkvhBT09T/ae30F1OEjayKc/YSWjN0tvHAUW48EB
	Jf9zlO4uelR3/hOxqd1Wm4/90DrRvmymrN7Xy+JpKX2JOX+T+HOb+H/NxJBvRwx7
	QzBb/y8lnroKKEvDqCjP1bFHxPUFKq2VvAP+LmgI5p1f/e5g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgscy940y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 06 Jan 2026 09:15:26 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4edaf9e48ecso24546341cf.0
        for <dmaengine@vger.kernel.org>; Tue, 06 Jan 2026 01:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767690925; x=1768295725; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kSJ/eEbuN5yGHUMen9nJkBt0F9uVUPS6BNRUD76mvkI=;
        b=Vc+zioEkzEM3NzHzFmPDa04GDaktX5+Q2D8Sx8aeoPrJfzZYanFN+DgXMgVCa1FBpo
         ElaVwZ1WsDGBTbgPKKCoHGMo5UTy29UAOSghDMJ798gLR0DA3YBz9vAMY3brCrl8L4RJ
         IR75kbU0u1Rp6kqBc0SYBBZo9S+QIS6O+S+uusP5Rx5Srroxfug/ozMKgAnp41CCHRf3
         2J+dODZ84MIfx8nnIcV+yIZUay4FwXuAnUFcAkSudZhXKoEyQVgA3kg/bffhrh2zHAzf
         R9bT6MNUBDJGGgaO+aAGJmvu6faYxx0B/1Fv9lCpMFPwsB9L7ZHxIJlXgC8XjJEHmc7f
         mRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767690925; x=1768295725;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kSJ/eEbuN5yGHUMen9nJkBt0F9uVUPS6BNRUD76mvkI=;
        b=P7ny+Enj6y0JT4ByGiMmrninwWltAKlVhWMTU70o1NXQafKxI7D+5ygeDpYlZYYxh6
         T2apMIDkA9kpLAuNjXTn7tXRvNs3iljk75ZpfxFfGxANXcBFBQMACTYqgsR961eb1CEN
         xtNdLWzmPJ20ms7DqIe6Xu8+Dsc3T+tp7Fvw8WKTqTbjsnTCIePvLiS+/tNwr5plKV7G
         UN+JXmIkNvUnKpJKXGdCJW6pJPDn2uRq7bld4AgJd2UPjcK5RPRyeUWBTnTGQOgNrRj8
         9EzasDn+qTMqZ1WEV0vLvJ96q2Z5GLPCxy4ANM/M/qFgShd445KI/isbl5SpPskzAjSc
         y5Xw==
X-Forwarded-Encrypted: i=1; AJvYcCVsKDqT5EdfdurIp+iV1SsSNe7CdfTY/UV2pNcLBX/QbUpSrdtVtMB6M/toaJB7qgfEmDuYy2HM7nk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGRFoxLuRS8FBKSNhGes5juHmIB3njDlM9zCwxpzdnM8dLQXtB
	XJpDsbboSOIVjL0e4tK8JfYITXAtLbRSqR4TL0u6OnfR3G+c+GdkDLe5x0Wo/YWAkHW2PCy1yWK
	VEu+MZqQW8kjvQO6HMWsILCls5oT3ysjoNGSqxvmfhZTGXaVHbubWhgwPkcu11VM=
X-Gm-Gg: AY/fxX5YmdUj9gS2+36rzWOYas90/VebqS3fXMiThsTAtIQZHylCnBc5tFfqiE8E8AE
	J3TNbthjqGeKHf5X4EmTHiwMyKXQR+8CgG5yrquVjLMGvvR8RMzhSfaK7liFJhBxCOav2w7Yuwe
	1k/7Xb6NbRRY59ufGg0YNXvFgUrXOwSqQTgI2/44agREO4AdIK9CuWymUFz9ZXHC/tQo9vbVIzR
	JQDTr0yikaX6uX1thK5QZrCjjFtKHDhWhbLL9gkKF3biPipB/0wVZb7ubhUAO0omMoSD4oG9Y6n
	/xyU+mOxSiPFh3VFbTBMe/Uz1xz9Ac810G4Xcod4CZvD1JJ491YFCmfmuoeNjmzZJ5DYScjgMQb
	3VSJm3ifQpA0Dd6NHON/nYwRQehU22w9ZjA==
X-Received: by 2002:a05:622a:5a94:b0:4ed:5ed:2527 with SMTP id d75a77b69052e-4ffa76d83edmr31813451cf.3.1767690925594;
        Tue, 06 Jan 2026 01:15:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQYNJNT9XBZBlcoB2R09/O9ycRMo0pJbxtqm9oFSewi0KPlk1loubxpFadTbsB+xmiZjYXsw==
X-Received: by 2002:a05:622a:5a94:b0:4ed:5ed:2527 with SMTP id d75a77b69052e-4ffa76d83edmr31813161cf.3.1767690925163;
        Tue, 06 Jan 2026 01:15:25 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ff319sm3271370f8f.43.2026.01.06.01.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 01:15:24 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v2 00/11] of/treewide: Simplify with
 for_each_compatible_node_scoped()
Date: Tue, 06 Jan 2026 10:15:10 +0100
Message-Id: <20260106-of-for-each-compatible-scoped-v2-0-05eb948d91f2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ7SXGkC/42NTQ6CMBCFr0K6dkhb/oSV9zAsSjvIJECxg0RDu
 LuVE7h5yffy8r1dMAZCFk2yi4AbMfk5gr4kwg5mfiCQiyy01KVUsgDfQ+8DoLEDWD8tZqVuRGD
 rF3Sgr0WXuc4ZXWQiOpaAPb1P/72NPBCvPnzOu0392n/NmwIJOse6tqqqVJnfPHP6fJkxbqc0h
 miP4/gCVMO77tEAAAA=
X-Change-ID: 20260105-of-for-each-compatible-scoped-285b3dbda253
To: Miguel Ojeda <ojeda@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Nipun Gupta <nipun.gupta@amd.com>,
        Nikhil Agarwal <nikhil.agarwal@amd.com>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Vinod Koul <vkoul@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        llvm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-clk@vger.kernel.org, imx@lists.linux.dev,
        dmaengine@vger.kernel.org, linux-media@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2503;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=yRljZXW19bL9W7HE6hwL7lUsKYJt+g5uw13tOylCf70=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpXNKgWPkL/X9B0kG2wUAH/3eTCaq2qugcMredJ
 KKTScL1obSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaVzSoAAKCRDBN2bmhouD
 1wgND/47Id9EUUTVq2uKIiVZPyo1yp8da485u5W3t4dAchT72VuXV9Y6vKdcBt/nC96bIHsBsrC
 sXK9AmkmkMXhNIEzVw7moTKJHjbihXpyx33M2PaS0Qba02uKGDR/1Z8DS/FsIX+HkXvS4dKFkMr
 M9U9SDZv4zLSbQYtRLWEwWaiphkQyNYMul+NQPQeQb2hahhJS08BCmUTmB0WHo5R2CaAe4VXSsZ
 4/IBx//VTb+nBHW19EZVjY10fCyoJIEs1bbfrdhj8ALft5yhYGyKh91733GlSrOAxYS4VMigtii
 4vwOBDNFUdhWomkQTAucVgvS/jyEYq1ZyDIEkPk73tw7exz3vxxg6MY/Voo/I30IqKvHHKX1my2
 tqpTA7AOCBxVY/w6GDN2yftDSDraeEI3f+5ch55tXZj1gj9PF6V49cXNOPTvzgJFyI142eq++ls
 J1wsXLhBOwMp6iAx6lqV/UcKyJWR3P87F4YaMAKJrkroGFnG/XMc6CKbTMPn1n5DdQbd6frM5po
 //0gqRnPSCROhzjiahO5n1S5KG/nINY2wRqYw+aEyUluPGejKRFfq4q0O6u3MLUpbdTJwKtm4ob
 am//Nbt/BaDCT3Xd9Iv6CF6Yc6Q/MFargCzfOUderUoTTJ9X63w2tyWVn9S7U58fyP7B5ZNfdLN
 /zK2P0SbCUJMIbA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-GUID: iMIR8GFwP-2g_W0mi6srVzF--oTSc57i
X-Authority-Analysis: v=2.4 cv=fOw0HJae c=1 sm=1 tr=0 ts=695cd2ae cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8
 a=d9g9ln5aRjr3gUnP3tUA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: iMIR8GFwP-2g_W0mi6srVzF--oTSc57i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDA3NyBTYWx0ZWRfX6JMURiMUyR00
 7y2bCg4IkL0WOuS2MhIFmrtbdygbr9LSGqntZp9+1auvXZm6zbSOBYqVI+3926YM7ubZpvXq1Tg
 WdrSWJnxRvmMvuJMRGAZ8FrbJ+KOUMRWv+qnLPungmr12TViraaNsK144DrScNOYLNU3kO7P1z2
 bSO7wKXeGR0MWsyFKm0fFxRs76w31E6vWa0sVVKhphbV0pDmvn5/55NQrIlvfTuRYOz3DNuqqam
 1gSCpoaXXCPhs63tFZxkVfHw9HwRLxIlhLzTRV7sSOAIHZwSNMJjk8aj2Ih5a857c1imP34cXLU
 risRjn37+BhPAqfM3FsuL4k6VtQrHW9tluCJHqwCuCVTM329amaQHQrQtMM7odbehc5LvbmQS12
 auba061Ja78ZlLQ0pxUaRGFiPioQ0zqWxjujhMB/hC2s35WgkO4KSVOdJ/dgjFYk5weX6aTX2AI
 ZEqW6H4LlsaSqLdSZVg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060077

Dependencies/merging
====================
1. First patch is a prerequisite for entire set, so either everything
   goes via same tree, the further patches wait a cycle or stable tag is
   shared from DT tree.

2. The last media patch depends on my earlier cleanup.

Changes in v2:
- Update also scripts/dtc/dt-extract-compatibles (Rob)
- Collect tags
- Link to v1: https://patch.msgid.link/20260105-of-for-each-compatible-scoped-v1-0-24e99c177164@oss.qualcomm.com

Description
===========
Simplify for_each_compatible_node() users with a new helper -
for_each_compatible_node_scoped().

Best regards,
Krzysztof

---
Krzysztof Kozlowski (11):
      of: Add for_each_compatible_node_scoped() helper
      ARM: at91: Simplify with scoped for each OF child loop
      ARM: exynos: Simplify with scoped for each OF child loop
      powerpc/fsp2: Simplify with scoped for each OF child loop
      powerpc/wii: Simplify with scoped for each OF child loop
      cdx: Simplify with scoped for each OF child loop
      clk: imx: imx27: Simplify with scoped for each OF child loop
      clk: imx: imx31: Simplify with scoped for each OF child loop
      dmaengine: fsl_raid: Simplify with scoped for each OF child loop
      cpufreq: s5pv210: Simplify with scoped for each OF child loop
      media: samsung: exynos4-is: Simplify with scoped for each OF child loop

 .clang-format                                       |  1 +
 arch/arm/mach-at91/pm.c                             |  7 ++-----
 arch/arm/mach-exynos/exynos.c                       |  8 ++------
 arch/powerpc/platforms/44x/fsp2.c                   |  5 +----
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c       |  4 +---
 drivers/cdx/cdx.c                                   |  4 +---
 drivers/clk/imx/clk-imx27.c                         |  7 ++-----
 drivers/clk/imx/clk-imx31.c                         |  7 ++-----
 drivers/cpufreq/s5pv210-cpufreq.c                   | 10 ++++------
 drivers/dma/fsl_raid.c                              |  4 +---
 drivers/media/platform/samsung/exynos4-is/fimc-is.c |  8 +++-----
 include/linux/of.h                                  |  7 +++++++
 scripts/dtc/dt-extract-compatibles                  |  1 +
 13 files changed, 28 insertions(+), 45 deletions(-)
---
base-commit: 4d27ce1b1abefb22e277e715901cc52acdc5af2c
change-id: 20260105-of-for-each-compatible-scoped-285b3dbda253

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>


