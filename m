Return-Path: <dmaengine+bounces-8053-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 179FECF77A5
	for <lists+dmaengine@lfdr.de>; Tue, 06 Jan 2026 10:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3164314BE96
	for <lists+dmaengine@lfdr.de>; Tue,  6 Jan 2026 09:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E7831327F;
	Tue,  6 Jan 2026 09:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AzdlmuaF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WdUhIa9p"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470C630CD91
	for <dmaengine@vger.kernel.org>; Tue,  6 Jan 2026 09:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767690941; cv=none; b=kWi6xDSvb9BwddOhj4v2zq8AsE/72j6Z5a4jr39BKEUoFdz96R8uZ4asBzQY+/OkWnjcWL61siyhCbpyfSqrm9P0TaFbD0ulhYoD8ggh+XjV80yTZA5bi236zUG00tK/0sTupa+ZqI9nd5lt3n78uoKTMkrKzD6uMLNDY0xFQdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767690941; c=relaxed/simple;
	bh=LVLzy0PUtWV8BS2tmtolxGrxYJ3Rutx30xWjiFUNeE4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mOgW42oZ3vohMK9lWCwKLc7fD8hxFUVotGm0Ei+q5gxNw0gIO6LfCohsHhQLoZ6oO0CZfCDXNEXs+j0az/wJdYAprGG/cztcs7eFIqgNgIGgCnFWwI+foepW4XHJaV8/gRtbp2vMuabThTt2t4YnG4DVTqdLcp37G0Bo7eSIIwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AzdlmuaF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WdUhIa9p; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6063QVDc3443175
	for <dmaengine@vger.kernel.org>; Tue, 6 Jan 2026 09:15:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oArkW0LARboCK7gb4mMn0LYpSg410D5nG+SDjMvZOYk=; b=AzdlmuaFqTDxLjwR
	lohgu46V+FUulxlb/1omdPCuQmuu7RqLlas8Etshz19artC/z6uv+dXK2JRYKQcX
	7HgPUw/LiSgZBfdQGZw1RSZBTHqHZJ2D6a0HhKa/4fXnE0y96Qf1h8vMgzoXtCGS
	Gq321I5RXI1D6J+M/ViyEYGaXnSxVGGfUC6thBoyAjA4mbnYaJ217F0lJuOwCug6
	d2HwfWpJOBXjws/GSKKkjQWlm4GfhKzYyZ1j4QO0QuGg20lLODZalEBtYszTnn3a
	nyYokqu4Mnx3NPYdmn1PyjW1dwSiZrWp9lvMntSgpzILBEc1n1xEmPeVTW0dqCow
	dRy6OQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgmnh9ucq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 06 Jan 2026 09:15:36 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b17194d321so106749485a.0
        for <dmaengine@vger.kernel.org>; Tue, 06 Jan 2026 01:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767690935; x=1768295735; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oArkW0LARboCK7gb4mMn0LYpSg410D5nG+SDjMvZOYk=;
        b=WdUhIa9pucU39sJ4c6AYEGdoU82kkYgNfK5+tvEyI+6ZN0Er0fyUozZKVrQtxvowT2
         dBDDrWnpyACHnfL9ac+QLV3nBPlkieEH1h2bm2mrL2IVbbm7OmdzejGPRbHH5Dn4JbPJ
         b1AIDD/OeHYolT3JQtzqHMw5Iw89zeQ3qF3UWBCvXtQ5tSPdOcQRYyU2kqZXpMoY6Vt0
         jqN8GL/EWV9b2Eu/RoGC+HFfwT7DoB333QYfVrzbZAbhhKnBgHJSs5lURmy2TcoEreVY
         E0mH8NQ9wEJjN7ftzFd4x4KKz7nnwWGcLT/6MukIDrs+BX4elChHn3EE6H6YgN0NXWHh
         ramw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767690935; x=1768295735;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oArkW0LARboCK7gb4mMn0LYpSg410D5nG+SDjMvZOYk=;
        b=VQOtuqOi00ha1zsBwnQSZWtMIH/hI40SiFTEV67bbDeIMILIIw98sk5Z3SELSsTfKD
         NIcJQcAwn2VEMjdSEKN4abfiaUiiDtHXGDq+unCDNf6USCpVyXBwnb3Fw19A8mEqbU4r
         Iy6zqZdphP5cKqgyilToXRJqyWFEcBUK0zVwBrDjGgNayWMMGTgYt5lZuKkcmzalqw/W
         3x2fD0Qt7jeGdHNr48zYIeUsfwqUIg4FF7b0SwK8a8RUl/YMzCYUXOzoqgEc6rAesInn
         9q3s8/Udzmqp0JSJdsBmZHpLamkv0/b5o/0apsNWhNGQOPAq6axigW40jegy9KMe4BZL
         TO8A==
X-Forwarded-Encrypted: i=1; AJvYcCVwtEiK7IxS+fXfTUYRBft4bKXTzXQxed0cqsKLVSqZ4uidAiinisybW78JC2ZnK31GvUKLJbW6LE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUno5mlO1xkJGD+8IGj72Ws+pBDI3ydsj6s62izwnijaV/IPY6
	SKkEKhXDc3B6xAqigUQ96XQXsyCzm1TTPN+df5/i6p47qZUb/iKD3q5jyti69aRRI5OFBdfFWP+
	Yf2biI+urWhqEfousUaFCC5N7u6U4tfZ/R4po4gNkkBlBlGE2a81ce4MYvWOpD5o=
X-Gm-Gg: AY/fxX7YPCgXGlVBn+/3Zc3lyFTTfbAbGIFWcQBxyd75DDGLqzOtpajwWmpjVKOKiOv
	Ic8/VEtjFZdg0XD1fjlctqwtxli4cQqSd9L87qkE5rmUNz4hyv6BZ+bNpv9Hqp5qh/vejCwHSp2
	eI09MvK6dXEsy0+J79v90T26zid0BG7zlfXnLIMprT7S7wk4sXT4zFo7z2tHkP6YxiC4OuDCCdv
	39eaUg1pQIft+CrM9Sk6yohINZUDkZGHwqla1LNRRDGfhVQGyFAbHzsOy2srs1qolV0XUh+fbeJ
	Ql1lq4zT+NA2kHvbepO4ghy2+iaLSYIxm7uRABq+GuZNq5l++GGWwDmueHD0FK7h9Bd6RAUwVkj
	WmKURBiwjUfIjj24ph7zDXwIgAgHvqDDHWg==
X-Received: by 2002:a05:622a:2597:b0:4ee:2984:7d95 with SMTP id d75a77b69052e-4ffa76a1fa9mr33065201cf.13.1767690935584;
        Tue, 06 Jan 2026 01:15:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHj9n34M+nvJtisn5mDYy5RePHoeuMJd4vqGss8fg8pD102xLm7ehjQZBfXUwHbXo0PbhYlFw==
X-Received: by 2002:a05:622a:2597:b0:4ee:2984:7d95 with SMTP id d75a77b69052e-4ffa76a1fa9mr33065011cf.13.1767690935131;
        Tue, 06 Jan 2026 01:15:35 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ff319sm3271370f8f.43.2026.01.06.01.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 01:15:34 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Tue, 06 Jan 2026 10:15:14 +0100
Subject: [PATCH v2 04/11] powerpc/fsp2: Simplify with scoped for each OF
 child loop
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-of-for-each-compatible-scoped-v2-4-05eb948d91f2@oss.qualcomm.com>
References: <20260106-of-for-each-compatible-scoped-v2-0-05eb948d91f2@oss.qualcomm.com>
In-Reply-To: <20260106-of-for-each-compatible-scoped-v2-0-05eb948d91f2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1293;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=LVLzy0PUtWV8BS2tmtolxGrxYJ3Rutx30xWjiFUNeE4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpXNKjqMnHKZ6rh4xskjSorjbJanJtC5Td5QsTN
 mTpfCmhXxKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaVzSowAKCRDBN2bmhouD
 107BEACFykt16DYNP4MhZ9/yYnB06mL7kkZ7VawN7JLM4VGMbZZnQCVky8Sgq0r62VsJD7jf76u
 qQdVNf/zRIeD/kvN9orKScdeDbI/QjucKwW4mh/7f5YQqherhONZveQt0LkbZtiaGFFT6JHpkHR
 zsuoQFMOCWk/R7xs6w4VpqX0vdPQT4m6hAUXWffthiPETAIPGsF1iw7xGlbmtSSOW5mjZbLJ3Oy
 06ZGo/2BVMN119RDQ1dIJpY1nYxwtLZfbaw6M33xnCcfOuM/vxzuwdRCIyW0eiMTlx2+iZOsZlr
 J+Q6NXbGc3QflgeCXkWowuJJzY7ntyXDg/TQmawr65rpzUnCSt24pjKYW3/WMuwj7yZR92AIAk1
 aottxgCA2w0R6uE3O57KbXDZuLEmXQK4cQZksQCm9IYD3T74JGOqlM6ecCJXdrSexAi7nEWjFJQ
 AI9w7ljNyiUl7kE80EV+AX7c4lOx7VQAj8rPZA6QYFHWkkCjOG75QvJX95xOJwQ0iw/5ACcqeKc
 SmTVGMdug9kP9wgBvtuKVW2HQ2Ff3sYSB8cJYSk0djxI/1uBo88xMl+pixFyFzGIJ613VXDvt6H
 KG7HY0sbmwXgL3R6lyid/9TFFYZLCTfvKMG+4Br99v52e9mbxnkCTzR/x1pVmzsgLGquiz4dr8S
 40GfezA/xzLZtiQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-GUID: 5uFuxF6hlzdZr-ovp6vWb-Wms607RE7E
X-Proofpoint-ORIG-GUID: 5uFuxF6hlzdZr-ovp6vWb-Wms607RE7E
X-Authority-Analysis: v=2.4 cv=Vscuwu2n c=1 sm=1 tr=0 ts=695cd2b8 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=bRA1xQHzFO3ZoMUYUbgA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDA3NyBTYWx0ZWRfX6N9NVj4/5UkA
 yHMcy75bH+YIzdONPvxkgoPWCl/kLaVZPrdK2sHLItJhrrCdVBoIZkBjVtaofCDbzm0OXOUoQ6p
 8g6heZQyKwbFhWAuklG+LU0wEMHmTUTTP8uLBURpGuhhZ0YeQ1WYow3lnTHyLfqpEXEbnYkr2Dr
 Fo3ESfIvdAEuLRSOsNs3Xl+hlp3hbHYgXBGI0moNz4TCi10WwMK1WkTODD783InNN27+z3eY0uK
 iH0UxAZsloY6hFHPkkAJ9KaGLLHnPAYy/nHCFH7gvnHWvqCGufs4z1JZdNiJEh9/66zLY5PKZZa
 /kkuxp+jtZcdRapfjvJF64M1K5yZNvGLZ8qyr81ppt+4PzGfp1sEmHyS4STt/KcmmYGt9C3ow8I
 CKSxeXES+WisQgY1R3QUizV+ez7gHLJrDveUjwCosQNwb7x6XKfnf6GuNk1ijPr5ihU9+wqYlce
 a/BgFep8gVq7m/BRbjQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601060077

Use scoped for-each loop when iterating over device nodes to make code a
bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Depends on the first patch.
---
 arch/powerpc/platforms/44x/fsp2.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/44x/fsp2.c b/arch/powerpc/platforms/44x/fsp2.c
index f6b8d02e08b0..b06d9220844c 100644
--- a/arch/powerpc/platforms/44x/fsp2.c
+++ b/arch/powerpc/platforms/44x/fsp2.c
@@ -199,16 +199,14 @@ static irqreturn_t rst_wrn_handler(int irq, void *data) {
 
 static void __init node_irq_request(const char *compat, irq_handler_t errirq_handler)
 {
-	struct device_node *np;
 	unsigned int irq;
 	int32_t rc;
 
-	for_each_compatible_node(np, NULL, compat) {
+	for_each_compatible_node_scoped(np, NULL, compat) {
 		irq = irq_of_parse_and_map(np, 0);
 		if (!irq) {
 			pr_err("device tree node %pOFn is missing a interrupt",
 			      np);
-			of_node_put(np);
 			return;
 		}
 
@@ -216,7 +214,6 @@ static void __init node_irq_request(const char *compat, irq_handler_t errirq_han
 		if (rc) {
 			pr_err("fsp_of_probe: request_irq failed: np=%pOF rc=%d",
 			      np, rc);
-			of_node_put(np);
 			return;
 		}
 	}

-- 
2.51.0


