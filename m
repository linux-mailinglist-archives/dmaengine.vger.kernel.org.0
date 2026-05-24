Return-Path: <dmaengine+bounces-10794-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAMEABNYE2qT+wYAu9opvQ
	(envelope-from <dmaengine+bounces-10794-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 24 May 2026 21:57:07 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4845C405B
	for <lists+dmaengine@lfdr.de>; Sun, 24 May 2026 21:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 647AF3042262
	for <lists+dmaengine@lfdr.de>; Sun, 24 May 2026 19:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86386333434;
	Sun, 24 May 2026 19:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VGsLT25h";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="brtmXI/M"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2C2324B22
	for <dmaengine@vger.kernel.org>; Sun, 24 May 2026 19:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779652236; cv=none; b=tR3geKsRAEM5S4ABurJU2MYmcQJUKBaUBUePHi1EGqgK2VLZtjCTJsPEidvjXQhRp/0v0IE5Di0Smgqmk3xuKr8snGRdM4NhQCyyiYYUW1rT7VwAvUwxNWNRCHa3/csi0+sSsehFteQRYqeVHltTM+oXC3xxE9fnHXNKqgBHJ9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779652236; c=relaxed/simple;
	bh=HZ7/7IjeZoPhuLN/esuvDjyXVaXxhOuhe52lN9ZMwac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h0NV8e9qGaI4TCMY7LxPldTKE+VKpNC8DQ6Zj9/jiBvNGmRHenmXYt7i+i19sUhn6OUQs5ra2xQf9e0/KjMMYCys2eAwD6TXhgKY0wi5YVhPQhJNxOuXf37cB+hrsoQ3xS3MlKy+7k+7FcvGuh0h4O0zmcnsgIIMTxmxVSFLdCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VGsLT25h; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=brtmXI/M; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64OJ01uN1670648
	for <dmaengine@vger.kernel.org>; Sun, 24 May 2026 19:50:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QjPFT0emV6C2WElXznwvtli7ABAsS8Isx5jqdt400LQ=; b=VGsLT25hOjHPVj+q
	99Ha/BwlM3UQP5OnOnUuBTkh6fYdcG7eeTN/peYQdg61tWLzHwmrjLhLOanIz7OY
	9/mdNZmYRy5ifXtJfV521+oo6794cdn6M/3EAOeqxidVDovpSNsXD62o+L9V0cT1
	8b7Pxfa19qB77fpZcD+G+ZSzSvQ+6j9XGhJrVUOLl+Kuw9ZT+4ZoFMh/6WggzQEt
	ewhJfdOtJT8N5UDfLWnKXhMcJoQTVrZatYzudB5UB6rYLWPWXatNo1mNTX1JMyGu
	Zoo6qIsvhk+Sz5Tn6lzG5GJbhd0qK0Q9M9IFid5FCKymHZRZaMseZySplCOtF+2r
	xWiEWA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb4m7kuuj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Sun, 24 May 2026 19:50:33 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-368f2d76b04so8030061a91.3
        for <dmaengine@vger.kernel.org>; Sun, 24 May 2026 12:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779652233; x=1780257033; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QjPFT0emV6C2WElXznwvtli7ABAsS8Isx5jqdt400LQ=;
        b=brtmXI/Mv3egUhAXroXJ2TxGnttUkuZ6h3dViXCp4GUMw5ojhbyclbmVJaspJusPmo
         Qs4c+Rea6xp4Ev0rHJi3gzJmKF9S2s/UIMXHSBVQB7iXdJ3X8aCDdwrlh5jqLwZXlwdb
         EkYQEVPZ7YXikafCgvzDr3yPoR3ahO7a6PvEcl+wg1BK+FEjLL0NvHtGsQvMjunuWQvT
         32SXuSJ3zrBOaJq0Ks0PaX/muMSBwqbDFFwp7xsQr3xOVItj/jLZu9UH83Vm/4bLHWb5
         VK7NEtFDcRQQHZWsQKvQbPIblknic/sFJVPBKU3nyGk+77dJpZuuIU8FCe0w/3avbuMK
         o/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779652233; x=1780257033;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QjPFT0emV6C2WElXznwvtli7ABAsS8Isx5jqdt400LQ=;
        b=K36Osk2uFyaDX2hXBbH6x8mkCpAKHDATuyA6lpP3KT53iMLrTGCu7mZsu/otPz1/uy
         nvJbxHtRy2dKtoFmyCleWd06gveF1E1y6tkuEK5s8W/eDhMKYa05kdMubHRkTIboOyVI
         AebmeDEXAwRI8v7mZDOFZgxnByATzFE7PiriHsUv2ykWfBqXSn0BUa4fcxc2vqalaAA1
         82Jh47yH/kigrx2f9QuduGywhnn+hhXUWz2VaIHCFRVkDEz6qWMLOHDhhShmmxkhCPGq
         cQ1lCNPpIO/U2oyvV44Tu0M8hfCWG0oIfx/UuPhJ1WB86qnTP9YVTrIRhN5QKm4ymIXK
         QCkA==
X-Forwarded-Encrypted: i=1; AFNElJ/Z++8vRL2p8TFS86gipN5TPa8NWZLGJZcD1sq1lcHqGDK0vMcv/6595eN2Mc9um0iDbTqfF22cBEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSoxzVTVNmdGP6OgUUUXgzenCyaKvw+7HNvtfdgF1NM64xirh0
	rUrDO1N8or90mFX56ojyPQY4XX6bJ8/LTaRXMuk792hc6hJb7TW8DyL3+ykoeAT0RDlB4SsYP8z
	ofq5Wha//Lys9lEiVVZXO3gkrqx1hnG6oJIaADxKbHPuPouX4iwdIvI2hF92xjsY=
X-Gm-Gg: Acq92OGNJf0h6TZoStycMHeuah5ZKGphRCV8qNFpxyZO/mfMVnKb6frBA5fk15f9PT8
	eeZgdb91b35weFB5Y+I3JhTnmBGryDPOLB7odEPGowjaHNRU38SE8WWQNVGDXfGMlOVa9Op2MDm
	1RxypAsKdJFJKjZZqATTrX5tm8pDZ3q5qXuR01B3vtint0N9aInAO+MclK2kqZ94e7rNIOKOtXG
	JP9SBJ/1DKTbauxD1U0Jo9yzpEyYjvEQax+yZLyGIWUgSaVPI9Ls1eRgNhv1ebYn8O2203ZdBVh
	nVxMzjMBTgRw4XihPNSoiGC/EtBURU7XinsEAvsd0EHTdJGAz789IQfIkby2pC5g47p9E48v9N7
	KrneFW0kRFFrvOArdDXSvYFED9+Jvo+kl2Cuu
X-Received: by 2002:a17:90b:2b4e:b0:35e:d015:d675 with SMTP id 98e67ed59e1d1-36a67719220mr12526934a91.7.1779652232906;
        Sun, 24 May 2026 12:50:32 -0700 (PDT)
X-Received: by 2002:a17:90b:2b4e:b0:35e:d015:d675 with SMTP id 98e67ed59e1d1-36a67719220mr12526916a91.7.1779652232445;
        Sun, 24 May 2026 12:50:32 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a6c21d4a2sm4725849a91.1.2026.05.24.12.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:50:31 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 25 May 2026 01:19:16 +0530
Subject: [PATCH 12/16] arm64: dts: qcom: shikra-iqs: Enable CDSP, LPAICP
 and MPSS
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-shikra-dt-m1-v1-12-f51a9838dbaa@oss.qualcomm.com>
References: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
In-Reply-To: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779652157; l=1018;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=3Lftxp5wY6kDco3NZNja7NALjN725ANWhNeWOYYhkAM=;
 b=VrlMrPDl3C+ezrF9VyKFMopuk63KiuZBmykDz1gHiy8/Xii3Syr0n/6ETHr3lm44J6ffV2Mk2
 Vpstd7HuwODCUZdQlaTB1cwRi31DZ6GYbrvzsJUoaEw/5kjiysAkIkL
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-GUID: sH8t6NuYbbBg4oQls_UkrXUn_wnQwwui
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI0MDE5OCBTYWx0ZWRfX1fTO2W7Nmo62
 Unia+dOQrfHxv7bf26z5NY9Tqw/uLsdkZ7wqrDQ0VeCvr8RsxnD2Qdqn78WP1NNDWmnGpBbLCuC
 54hxDzGUqX5ThgqGgpC110mKFnXg9VfJ/YkrXtPIawWLq37qDC9nO5o8edb9nvnRs17+hkUBjqq
 infw45z17WforGqvRt13hdldtePpkteFOMuyVGB7Ucrcc2ovGUAeQ4LWiAN9auGcpIRujoY/SN1
 voXidqg8IQFeVupPaS+iyDiuVowHcB2qluWH3kSM/A+JzSa2KQKYHpbf9KAEY413UUrlcKo0LjJ
 lxsoZdH1LM61jA/pwXjt2M3bxIuKl9ENNuTZqVMQpl/M4JBqu8DDVuxrjJpgl/KfTKLEYgP1fc3
 Y3s7Q6V+3OxTEy99W0SLUq7y1Iky4abjXJmnJXWG2i7ihH+0L/lbCwUm1nHIDW+wC24TVOgb7xq
 7uwl545z/JHj6Rtm4Sw==
X-Authority-Analysis: v=2.4 cv=MrJiLWae c=1 sm=1 tr=0 ts=6a135689 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=O3QOSsIWTsd9q-9u8mAA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: sH8t6NuYbbBg4oQls_UkrXUn_wnQwwui
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-24_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605240198
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-10794-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4E4845C405B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

Enable CDSP, LPAICP and MPSS for Qualcomm's Shikra IQS EVK board.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
index 3003a47bd759..727809430fd1 100644
--- a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
@@ -23,6 +23,25 @@ chosen {
 	};
 };
 
+&remoteproc_cdsp {
+	firmware-name = "qcom/shikra/cdsp.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_lpaicp {
+	firmware-name = "qcom/shikra/lpaicp.mbn",
+			"qcom/shikra/lpaicp_dtb.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_mpss {
+	firmware-name = "qcom/shikra/cqs/qdsp6sw.mbn";
+
+	status = "okay";
+};
+
 &sdhc_1 {
 	vmmc-supply = <&pm8150_l17>;
 	vqmmc-supply = <&pm8150_s4>;

-- 
2.34.1


