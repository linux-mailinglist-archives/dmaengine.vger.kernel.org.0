Return-Path: <dmaengine+bounces-8083-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBC8CF9D76
	for <lists+dmaengine@lfdr.de>; Tue, 06 Jan 2026 18:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F01843235203
	for <lists+dmaengine@lfdr.de>; Tue,  6 Jan 2026 17:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5479329D27E;
	Tue,  6 Jan 2026 17:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g7Tf7qlm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XvJDcQxj"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49752288C2D
	for <dmaengine@vger.kernel.org>; Tue,  6 Jan 2026 17:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767720712; cv=none; b=tlWgx3xLvyatHE9izblvf4R1ZEbA2uHBR2/bbiNpe4Y4kekdk+Cr0xDUyff1+emNLawU8Yp0UEqrPMzvC54SwAD0cdVpDKb5PkDW7HdIlfaLZ2GD7JE4q5EnNL/07AB8d4FCZTi6CCvNrzX9fs/9hvjmQX/DDPiXG+22egpWOCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767720712; c=relaxed/simple;
	bh=EGL0IOjXzoy4ERSdqnDv6XXP02+jdc63zjGvHi+5D/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sYnp/7XY1cBFWrA7ymgB6t9dGwxhr1lrPn6zST8xHeMsBj4qBJDbB6+/yqhrEjbNziC+xIY+tPN2tvnubtI4GupRNTPQ0H9dLexMWypOL671Wpn1ADpyORRWkZ0yWBqC5j1Cd4IvcZ0uC6xXTINMy7zymjJJyA6TQ4HBgsOrO5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g7Tf7qlm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XvJDcQxj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606AU9f93052743
	for <dmaengine@vger.kernel.org>; Tue, 6 Jan 2026 17:31:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=tR7f3o3xDPesUQHU2saQhPf2
	QeydtE64EkpRoTZj7tk=; b=g7Tf7qlmPp+umH1OgIEt2FQrpO5qwZlUUNF3FQZl
	HX1biqamPP+S3QFifEQzy9jaf2AY6vUJoF35oiXAOiRcf7HT/JpD4/pZg72K+t3C
	meDtBuSkuPUtpQRnlMI+BCeSgCLoRWGj5N8RRhOo6SsvbQAXRKQ5aOtEhqcE4YPR
	ygNhShsgBjdp+RDjAGGEWH+YOvuR9jhO2qYJ+ElfM8hMEzKhE2ZNzViBqTb49Tjw
	g8keG8le3o/HfvDI8obGawr+Rnl4TKuHIH1Kg8+DmX3jYJUlfvHZ3VLXqFo4lL1H
	x1kiM89xYc8xh3TUYxYELjFWUpGO4KxiTuAZ++/yYVIrPQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgpn9tw8c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 06 Jan 2026 17:31:49 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ee0c1c57bcso42871071cf.2
        for <dmaengine@vger.kernel.org>; Tue, 06 Jan 2026 09:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767720709; x=1768325509; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tR7f3o3xDPesUQHU2saQhPf2QeydtE64EkpRoTZj7tk=;
        b=XvJDcQxjmUl9PQvjrfqWiI1d6VDwVLqZPQnlBzshVMbkjnzywXWq/ahFZvrVIJMEI/
         lqudWxQQC7y+FTP2ZHB0VvLVFtPnQsyxPwg1LCRZnop4mhdx8VG/y/fbtiTAXO+rnA19
         wQuWVVBV865uubC49NW75wK6chLa85b5Qc923U/4zGQMUVW0YWXoJ/zw8+f/8e5H2B/d
         omrKfFqGPVlRIWVTRWomIcbFGPwmFxiyzpoC9p0vYMWT26p5pMz9v89oUCOCoGZrKq9E
         CRMxK6Z9Hj3+kLujrHEsIs5AKQ8pYcYHzyY7GmgAbincwqV73yM0F8SY/p50IpD0uXyb
         HTZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767720709; x=1768325509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tR7f3o3xDPesUQHU2saQhPf2QeydtE64EkpRoTZj7tk=;
        b=GPCp/2LkoEoDzHteB4hyYsQw1E6YAd0bb4zv16o5HcGd5+2Qhl2nyFkuQmIpvmPCyt
         ibqHr4ftqK+loW1QpLDtqxBefz1ZwGiJ3tAgKD5f57RiwjrGIq2h3EY8D8HbWv67xKzQ
         qqsRhi5+1OL6XbYQp5eT3fwhuVmn1mlIZFRS/fZfOlzNcEiKCelel5F90KQKcHTZtbTo
         izAkkzGo2GikRIJCJ4HFaZ780qsja5/ZmyY/zgJQQ1yjMUrDwL41NZZSycV5IoF9mPAg
         zAd6iBpxoUpPywwBSmu/SPl5x/evBRAyNLKrlJnRK0CDJ9qBYWIbnnN0LXbaqMTahd1O
         v6yQ==
X-Forwarded-Encrypted: i=1; AJvYcCUt8aBHuin6TkJprON9M4nh3ZcXKFsXUjZYlpsMHdA8x2ZEFU6f+6ofHZJpQMtfvSxzX2peMUNDfmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx79DO21eriGtXF9e1GAPLDzXxmphn41kwaNCSwRbOFKEzJjlat
	qBa5p6fHt0Aa5WAlndjM6HaMQZ/Q+TUR+icE+q+K3uf7h/rA8gjrTfZGaq2YCspLieHCtaPMqQE
	pEUZSSaGBTOR3caxMMOAfZ8Gg2Ka8kkLYJbvq2enl/NiLek3Jo1z09qYCvWZgWt0=
X-Gm-Gg: AY/fxX4nYODu1Ynl+hsPGrOTp3PAPXSVUDc5ubqzbIaUNuUzPnOXQ2xhfxIznMJ8uIX
	QsB/qaUWxW9nt6z5uGTbQSwUYUWR/jJWHOC6iMHdwHiLSnicvP9diviF9FexdgKQyJg0RVfI23B
	cd2GGldjhY1WoVzmZXir/ImftbrtsSPgIEwO6oITvzt6/RdBTTJ77t9lEZIqwinM9tTghx40dw/
	W7iBxEpXY7uliwoaBdEGB/R1YaBbxStVeOVRqzuUUEdYm7jAJyEHaT6020MPKJbQpVJdxScgfdm
	qCYtbIFr0OJB8OU5LNQHfdFx/j1fWFXnUYMZ6U6auwFeEdPKEQRKQdWUsKJLWBL5n1zaSd5togu
	b2UNQRTKM0VmNAeuAlFOu
X-Received: by 2002:a05:622a:60a:b0:4ec:f969:cabc with SMTP id d75a77b69052e-4ffa76a115emr42211171cf.10.1767720708535;
        Tue, 06 Jan 2026 09:31:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjf7OwaOn3HaZf8IWNrZ2eDSIxGAY9pKKIzvqd/zwCSP5LN8zraKCLgL67UkescNPyjj5pgA==
X-Received: by 2002:a05:622a:60a:b0:4ec:f969:cabc with SMTP id d75a77b69052e-4ffa76a115emr42210511cf.10.1767720707970;
        Tue, 06 Jan 2026 09:31:47 -0800 (PST)
Received: from oss.qualcomm.com ([86.121.7.10])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a51183asm282053766b.49.2026.01.06.09.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 09:31:47 -0800 (PST)
Date: Tue, 6 Jan 2026 19:31:44 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Rob Herring <robh@kernel.org>,
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
        Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, llvm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-clk@vger.kernel.org, imx@lists.linux.dev,
        dmaengine@vger.kernel.org, linux-media@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 08/11] clk: imx: imx31: Simplify with scoped for each
 OF child loop
Message-ID: <x2md7iusj467bjmmysckbkehooua3he652qqwr3yzaoka4sjm4@pk6uy7hq2lku>
References: <20260106-of-for-each-compatible-scoped-v2-0-05eb948d91f2@oss.qualcomm.com>
 <20260106-of-for-each-compatible-scoped-v2-8-05eb948d91f2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106-of-for-each-compatible-scoped-v2-8-05eb948d91f2@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: GM2e5jOBZe-5j3VWd6_Lkg94KpbscjyJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDE1MiBTYWx0ZWRfX5h77hB8IjU7r
 aRswJVeIfPYR9b/ESOjpZp1GvuQgXxriVYtJf3bmSKDn9HQF0VBoUEsk6xgKid6uiDtaizxMXVf
 aPmnwW5lryT5hjthZGKLrMiGDcq1/77vgvCNH/WgRELQ5tZw+KGomfG+/YSIw2RsAAUOGGfmA5C
 YisbHDrpzsyhRyDNxkmk66PvQN1Ik/QLEfZgmpedMpTDcsbyEWc4hf72TiiFyC8BaqwBJjGIJGe
 /udj5oRTSmhSVw+a5hVtOk6vxNkP6e4tw7Xxm/tG6yujzikGBmk0jmiorsPP6lZ0K07p0WPVFks
 n0JhMf2rKgLEmg/LobS89Azn2xfrfp3+KxuI7eV/m+2ZoFqBwrsbIh6+hMuBl8cidufmwOirpsD
 XZMXgndTmROOvwd9/CMxrKh/o7PqjcX4D698b6263TfO9Mi8smm8crT/JFCRi1Gk4ldez7fvTlt
 irPYTSZ03O1mkwt+GbQ==
X-Proofpoint-GUID: GM2e5jOBZe-5j3VWd6_Lkg94KpbscjyJ
X-Authority-Analysis: v=2.4 cv=KfnfcAYD c=1 sm=1 tr=0 ts=695d4705 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=hZ5Vz02otkLiOpJ15TJmsQ==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8AirrxEcAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=_Ixbbux_C5oTi3JCwyIA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1011 spamscore=0 adultscore=0
 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060152

On 26-01-06 10:15:18, Krzysztof Kozlowski wrote:
> Use scoped for-each loop when iterating over device nodes to make code a
> bit simpler.
> 
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Acked-by: Abel Vesa <abelvesa@kernel.org>

