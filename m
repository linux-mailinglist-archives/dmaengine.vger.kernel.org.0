Return-Path: <dmaengine+bounces-8024-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A979CF3F4A
	for <lists+dmaengine@lfdr.de>; Mon, 05 Jan 2026 14:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14310313BF2C
	for <lists+dmaengine@lfdr.de>; Mon,  5 Jan 2026 13:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996D2335BC6;
	Mon,  5 Jan 2026 13:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D3GqdzVh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cXuffcsq"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEA9311C2D
	for <dmaengine@vger.kernel.org>; Mon,  5 Jan 2026 13:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767620061; cv=none; b=ZFH5VBQl6NX+4wL6DQVu5WcSrt2TDxZGdQwe+Ff6cBIYDI6LH+dchrp/Fxq9+y1v46og+wqC55iOceY0PEaDlLdxrtZGnPYEhoMIyNrTy3raRLJEvU8bOfvxE3pysyE1Y5DVD7J3LyavRQri0XbzrxjWPFtHTXJ7DXR/Fc5+/p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767620061; c=relaxed/simple;
	bh=gMZzaSjVY4tZVvTQil8VUzRPtCxKhgc0IHDLGyDrZk8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CRIOPlxK0rbTvHuai2rCMp1Xbb3Iz9IiOFpRzjTuV2yf0Fs9hiYA8dKQbSOKhSlER4ULdWLc7It4q+X/8eOP/BDCYmUxkfvZuesyjKx6RYIc6xhCykV6mn1Rfhf/JvQ4HwQCv0MKoyJPiUk3mGBq6wSK/KanXb3wBr5bxAZGx1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D3GqdzVh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cXuffcsq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6058L3bf3964598
	for <dmaengine@vger.kernel.org>; Mon, 5 Jan 2026 13:34:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YTDHI1cVGuUbPTIN0iIEO22xYa57+Aa9xdC1m5T633s=; b=D3GqdzVh+P8lxKak
	xY2E7ZQ7eyOZAywZB0ey8BU9stHjORNWbthxMrjWcamgAjxRHkm5TTsw2VczZXjW
	ep0idd8VLSlcOj5bIKJU+53zQ0N0ejTMiwQB4Crz+9/eAyrdtBhr975FGV5XM1W0
	EcurEwtrtt850S67vxxojPCWY19oepsMGQTG6XTGQIHdKGlE+qRmLxQNKN0csOuM
	bGNlcvunqwF/IaB6cgeO38Q+hpugBLYAZrFDpjBPbY7/UeJW/do5EB4/WRAx47y4
	eGQGPryefk1jqA0BQuW1+XGQHhY4nr5FwHs//kXpjJeDgk2EUghlVxQxqcoFRvfY
	CnGxUA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4beuvd4kb4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 05 Jan 2026 13:34:14 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ed69f9ce96so523310081cf.3
        for <dmaengine@vger.kernel.org>; Mon, 05 Jan 2026 05:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767620053; x=1768224853; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YTDHI1cVGuUbPTIN0iIEO22xYa57+Aa9xdC1m5T633s=;
        b=cXuffcsqdtTmKI1uPGrR8NzNZWvmsXDVvGgeQ8EGIiMp0LQdUGIkd4Pm5cHxRE4zy7
         r2QlvgCe1NRBjOiwmTPSpxXM8Crk0y5H3Jr18XtVqcmqLznKH06HNBHX9YdJn3KbRrfZ
         sWfekoWa4skINhmIMmkdCokQzGb+rQfyT6/VQdCOcyefhW1tCfykXBfxkZsGRZBZAiAt
         srRjExx2GWNYL6uDNgmpsWUEi7D6v57tCt3yvgUk6E7CQx5SyyOHaifUWdntCZBMy0jE
         s6uF0OnP+40FoxYTEI1hKfoMWcDmuH4/ctv3DJQqQjOSDlHU7Wp+AajKNN69nMNKrg8m
         URQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767620053; x=1768224853;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YTDHI1cVGuUbPTIN0iIEO22xYa57+Aa9xdC1m5T633s=;
        b=U9YaiItS1QIMFh/RNhN3TqhCDKQST743Dc7+V6nfSBlmPxg3W1CFk1NdgUPg0ed3c7
         uU7YDir4j5C3ecmqIuWdva8D0mOKUEZUNsdIT/fpg+yVGIoGTU7OztyAsVVWoKFB8zND
         30bY2l3DOAsFIV1JTm4uyMNCY5gbvONmePbzt+KfTAg9mJ1WxXrkb/4F+jE7EyaMb8Gz
         p3v3fgGlh68Ih04yWr9nriCv2ehB7rXy1RX8U3ZsnMmFmscRiWKS2chtm7kk/o7Jdg8v
         N1kU7HHST04CPE/zglf24Lpja+GqxYaW2vuPKsTXUarrj3FtL8SmECWPbfRTvKh/wPGo
         uBWg==
X-Forwarded-Encrypted: i=1; AJvYcCW4M8aoNyIjK84Wr16Oqm1NFHuUF4l4MQean4BROXRpTyFmqfI3nrlM49wSZwk/gHOuIqKzuSPIciY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBLphmpW5J8uNR9OuDPDgkfcUMcPiztjIkRtvPzZTTJPq00hBO
	EGuuoPfAfurpErQm//fec51yhO1yn7YnzPEBT9PE1DdbNOArOp07u16w0Z6EkWkg//CYkM+1NQV
	FRLrMaNBrSzDK7vskETHbwvaFu6UXH0fgZeyUkwlUqOvKT29pHs8uyyk8BcOZRWg=
X-Gm-Gg: AY/fxX5QzVs9vYQ6PBMydQgH95SMM9SlZNzSB9ktAHoszf5O8DrJK7UIoVSA3JMUWwI
	QsXJdsqw5iZbi1PFnIBJhsYM3kHpcdDujdTl5H/g+afeS/AA6sHDcVJ35a9yOkzY1GL9pTgLwPv
	2TbvMpMQVJ8I5FewckNkXzY5gPIpzA7Mu0U2QLYcSabBHl7YSrSI6/2f1yrUTPumRKEia7E7UlS
	vxzXE8+4wom0/nQ8WfEskB9+sycWsNMLs8Wx+xJZioGNgV8ZAZ2MXputb3YSKZMmyDYhiSVA8ct
	KF4SpUpNDl/5fJks9EfKX4sP7zNYIYKQUoBld0kLnIBo3pDwqcBzSp+4yxegRg57jU6HkfjVE8R
	TlGKgMCzUn1RWLd3bwODBrvom54TY8oU4bQ==
X-Received: by 2002:a05:622a:590e:b0:4ee:4a1f:f8ea with SMTP id d75a77b69052e-4f4abcfbaa8mr830029031cf.31.1767620053151;
        Mon, 05 Jan 2026 05:34:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRkO0NCONkJWWXhAzy0ep55XiVJsUEFnaFCHhzMHAZVNsj44tHSkLbWNbO0UO4vNIzk1ruZg==
X-Received: by 2002:a05:622a:590e:b0:4ee:4a1f:f8ea with SMTP id d75a77b69052e-4f4abcfbaa8mr830028281cf.31.1767620052729;
        Mon, 05 Jan 2026 05:34:12 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6d143f75sm147211015e9.5.2026.01.05.05.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 05:34:12 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Mon, 05 Jan 2026 14:33:45 +0100
Subject: [PATCH 07/11] clk: imx: imx27: Simplify with scoped for each OF
 child loop
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-of-for-each-compatible-scoped-v1-7-24e99c177164@oss.qualcomm.com>
References: <20260105-of-for-each-compatible-scoped-v1-0-24e99c177164@oss.qualcomm.com>
In-Reply-To: <20260105-of-for-each-compatible-scoped-v1-0-24e99c177164@oss.qualcomm.com>
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
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1126;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=gMZzaSjVY4tZVvTQil8VUzRPtCxKhgc0IHDLGyDrZk8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpW7270TUaY6iNZZ3USQUUPyMVYCBnPviUFAJQZ
 SbtcAwOUwCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaVu9uwAKCRDBN2bmhouD
 1x8WD/9st0kAgDjiJuLHe/DH08bLcxWpCZlth0KGlKegvN8Rj1R0QAKsyr+7yQgZJxI2zmLbtFu
 uHevP6bF88adt/4FfMMTJiGlsLLnnNw47I9kijxa0eob+ij8Q3c4aR2RQNI5H4L9YXS4GGvFm4l
 pMPr3mERDghSCXHaRRJ9AVOnaM9NGSstFpYBt9sqyql/tc7k/m3/Tq67I+dU3QIYbNb1dGl5m0r
 P0A++LSAUbLCusxVP9eWtPhFnS6fFF+LCxC5Cg/flpMX5y7tRoKcDHxpQgRpb1B5qxC20qOyXmf
 2ykplrlmCi4Vi9hM5euEu8cppTm6YFs0QTKW7YqIHORm0m5HtodFWLvgPaaFm2bg7uW9vaVaJER
 NQgrU7y+ZO6aGc8GOpjcLJyBC5spVcsUdcRLltJdlB3i4P027abTyxNlrmpQS96vY5i5WvX9PmH
 vRi/vBst2K2QmXUi61j7Gt06cNG5Q7aufKqp1FTFV1XgEiyziX5mbOaz0CRmmwP/DVMKF3PCCak
 kbVgAYKAO9V9B456wwx3hpvNokZHMHAnzIWeEXFk5LCMUXIK2shaxjWAZaJhvyUiaQxI8UjQ9hN
 yaNEWVOyWGWzXd4gkhRzptnmx9kCYHhUopwuXudzrTcobAEHqeqJIvcbNSZ/L64QtRtNlN4eOQd
 wE4SrRsGoLsXcIA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-ORIG-GUID: wlgeihcg8IUkkMD2lVh0kh8VbIjfugUn
X-Proofpoint-GUID: wlgeihcg8IUkkMD2lVh0kh8VbIjfugUn
X-Authority-Analysis: v=2.4 cv=OuhCCi/t c=1 sm=1 tr=0 ts=695bbdd6 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=ZKLgdMRimQxpfTQYzWgA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDExOCBTYWx0ZWRfXykznVcQWeHeC
 6CHayqWwCX3JBgVFwrC7La7VeRE9+mj48NccWTbQVlks32w4holVrViHeTECMVLUKnvuXWehxDA
 YYARXkAMt7JvmVRfUQmOZv+jEx10tgQp3/Tk1i3F8fAmIdzrteDfvHDGaDCgy8iyKNGJmqOA4ka
 Wci0C4h6NAGO4G6W2Cc9j/AS9YG0mYZFutpmpwJH4LyCxjcAo0ykTjh77jZSckj0/MHRpOZIzLe
 U/uOKNggdUaeFYnyHo/+MErnDG2BqdCKr5skNpX7nIlgM0TW8z2I4n9Ee0PX4EKiBEDfh+IULNG
 NJjEE97uLjFzhOzP/2SZ1B7l5Ax+vkWfKwsrWO2JrEB7+aTjaB0IWOIAeDy9NFCeTty1eD9NgJE
 cpr5M9xEZkv+jkt0O2QB/OOiBDMSmPNXh8SEIfWqTvFwY/Csl/Yp+Zq8RZ8Q7C36HpwMUKK1uTD
 JhOh2OlbTswRu5g7iqQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601050118

Use scoped for-each loop when iterating over device nodes to make code a
bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Depends on first patch.
---
 drivers/clk/imx/clk-imx27.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/imx/clk-imx27.c b/drivers/clk/imx/clk-imx27.c
index 99618ded0939..f2f0d3fe5c52 100644
--- a/drivers/clk/imx/clk-imx27.c
+++ b/drivers/clk/imx/clk-imx27.c
@@ -171,17 +171,14 @@ static void __init _mx27_clocks_init(unsigned long fref)
 
 static void __init mx27_clocks_init_dt(struct device_node *np)
 {
-	struct device_node *refnp;
 	u32 fref = 26000000; /* default */
 
-	for_each_compatible_node(refnp, NULL, "fixed-clock") {
+	for_each_compatible_node_scoped(refnp, NULL, "fixed-clock") {
 		if (!of_device_is_compatible(refnp, "fsl,imx-osc26m"))
 			continue;
 
-		if (!of_property_read_u32(refnp, "clock-frequency", &fref)) {
-			of_node_put(refnp);
+		if (!of_property_read_u32(refnp, "clock-frequency", &fref))
 			break;
-		}
 	}
 
 	ccm = of_iomap(np, 0);

-- 
2.51.0


