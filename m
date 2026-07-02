Return-Path: <dmaengine+bounces-11950-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tL83BfY8Rmo4MgsAu9opvQ
	(envelope-from <dmaengine+bounces-11950-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 12:27:02 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 275C56F5E3E
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 12:27:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="Yw3gBxy/";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Av2fZdrY;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11950-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11950-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 03C3D32B5CC0
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2026 10:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F644DC520;
	Thu,  2 Jul 2026 09:51:25 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DEE4DBD97
	for <dmaengine@vger.kernel.org>; Thu,  2 Jul 2026 09:51:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985885; cv=none; b=sIZ8RXQb5kjIbwYqQNcuNCJJKaKI6/I3san4MetebydctjNJhGf1gqRpAzQ3nVkk4cv+CKIpgGcu5SY/B1SNx0EVNJAEtTZgzIJj7rqRTIFHju4UjS/+DmXmybg7cdppPjKdc2k2Lxqi1GipMFcc051r4LNsAOKlcFlxKs2yB9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985885; c=relaxed/simple;
	bh=e/53ppasmjQDhLX9UrUFxxcmkhukY8WHn0fzriW24gw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fcUGJpVQSZwLilRB06V8c7md/4Td5i0dLje885cDR5109n/LOYIJovtiFDfHsKPVWn2P1ev6GyVLVtwNKfxoPE4GM511JR/yoRhoSUGODfzCbqGwzvwcQ+pu47W8QXw+k4Z7AiqoBrZc74YgDKFI1M+h8PuBbi8KNxRMZAX9i6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Yw3gBxy/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Av2fZdrY; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6629KfOT4115963
	for <dmaengine@vger.kernel.org>; Thu, 2 Jul 2026 09:51:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SPc/msxlXrCzKPXdcDmMWZb2kXigoey6CgHTW67K1z0=; b=Yw3gBxy/qaFa4dH+
	Tfn1XbJUQ/vttb/ZFYStefXAyLCSxr2woTFbL+YNWsw/elbJaH2L3MP5J1yKYjfk
	n4UCYKKQ5L/fdgF4iEmuzu07cbaeIafazZ6J0nP6If9RVKpJZgCApTzDV6sHeevH
	FVDQzCUSIvfSh51Z6kf2CtpbGuCMY0eEPRLF+oW0BxA2rhtWsCSaK7qQhl9MlebJ
	IyZ/MKn6WCtQ+JumtRE7LgrMxUfZW6CP2bYEukq0hnJxkJC5qoFYMtFMnGPYWyAl
	YDis87WA5zbdA4mHb/hIUUmhwYN2lG+2tavroDzw6tOk6RM+J9u51s1WpEyJVw9b
	w+QuhQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5n9403s8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Thu, 02 Jul 2026 09:51:23 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8479586724eso1835198b3a.2
        for <dmaengine@vger.kernel.org>; Thu, 02 Jul 2026 02:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782985883; x=1783590683; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SPc/msxlXrCzKPXdcDmMWZb2kXigoey6CgHTW67K1z0=;
        b=Av2fZdrYdENonhiRShJ5nURNbhNn7y7NQyVeCRzBUbuNbAyqVQY8NAnj2ui0cSzY5h
         jN6BaejPqNzw2XLAm8wJW6TIqrp1uTO1GMJmjzIqsh2DpKJ6goY097nStRkbwWRvUY1T
         77i5VYRU8PanMoStP+TtXw1o3x5IQO8NQ+3XQ6bltFFEk/ErGZMLOw2V6AD1qiSE86Te
         +XgfX2Rkt8/X+ST/435lz6Zt51FgNlpz7Pzwo/yNwika/SyK1oDPeiI+cuepiG8fRUrQ
         ppmbkGs2pBuOY+RBh2Z54Opc5TGI/D8ReYZZQvmK+/0P2QM7Gz4VLvFn6SofZKz+1+Oh
         mGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782985883; x=1783590683;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SPc/msxlXrCzKPXdcDmMWZb2kXigoey6CgHTW67K1z0=;
        b=l8XgnwbGe6V5HbrK2+eYe6IE9u4UTg2PgvmeBXRtXMPSugrYVjQHXIDaEjD5uzHAUt
         PHpxA+eyVvFCaijHFloTNejHfFxfzHQon6n1ZYMXAaVplYTI+av+tLv27IJA3jwp3eOU
         j5mx6qEZQcJlZI+h7aML3vquc5PMnilB3ZOb4bGvajRUaSG99aKZ+47tJL0xcpuOv/Gm
         ki1XaVBMGn7CvP8G+EgLSPfO1ncJd1KQoO+HG8LhbuU2xv0gDBX8cWHV9J/DgI29sIRw
         1eEddrmNGQwqNvHh/Rkq+xA8wSCz5aDAm9aDrsyJodGH+PknIyaIldawxNS3zhFxuZE8
         5xUA==
X-Forwarded-Encrypted: i=1; AFNElJ/BQSw3T/5pw/6b9SbpkbyLWgxXLCIKnPBxkp0P+cMfictamABVmFhOc40h4s/bVDqVeloHg4SqoOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRZ5tufYV6vkJlZnvDn0JS52RwLMHcskRv9hQMX1HfbRi5YPkz
	UsB83HnPQLpgVC+Q/z+VNw/iLkcC+jI/hPl1SkktoeBsKXJvCbpGeguh8UhTP0/4j+DRQoBQV6T
	S9ZfiYmLHfjIT5LnQY0uNvZHAeK6u+q0MJzBevSspprrCdwPxDDWdIq/HE4eDzFE=
X-Gm-Gg: AfdE7cmXV5R0cuK2wOknnVXx5VbxIgcI/Ngq41niV4vl1uJ0qjdpszG2Unej5Jvg8fa
	ycFXmHsb6t4nEwujtZ8zaQbVJRYsjwei6gOAhSIgXl+d4wXdzA6ytAqPtBIMEWyiOBB55d6hw8S
	KYCUU5Avnh3WvaEYGOHsrBdVQvKWPi+WPqr7ToDXL+NE5oMh0vsMfDv0VhNOa/8w3ibSiKJCatv
	qcor/LrilYSSDdga85O/7klekMtniX3cP0RVMbWDxB3GK1OmtaPi6Rtukzw2Ow6nT6aMdfTXzZN
	in+0lce86zHixWHNVMttKjNxbDYVXwRMZk0QHr3I0bqAfuD1NydhN2awsOPALdrpcVVpePzKmD4
	EvVyX9dPyyYWZTANQIOYbEv3uLA==
X-Received: by 2002:a05:6a00:414f:b0:847:70aa:9586 with SMTP id d2e1a72fcca58-847c5039b2dmr3974084b3a.16.1782985882505;
        Thu, 02 Jul 2026 02:51:22 -0700 (PDT)
X-Received: by 2002:a05:6a00:414f:b0:847:70aa:9586 with SMTP id d2e1a72fcca58-847c5039b2dmr3974061b3a.16.1782985881965;
        Thu, 02 Jul 2026 02:51:21 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb78ee2esm1110051b3a.24.2026.07.02.02.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 02:51:21 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Thu, 02 Jul 2026 15:20:47 +0530
Subject: [PATCH v5 05/11] arm64: dts: qcom: shikra: Add SMP2P nodes
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-shikra-dt-m1-v5-5-f911ac92720c@oss.qualcomm.com>
References: <20260702-shikra-dt-m1-v5-0-f911ac92720c@oss.qualcomm.com>
In-Reply-To: <20260702-shikra-dt-m1-v5-0-f911ac92720c@oss.qualcomm.com>
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
        Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782985846; l=2278;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=hmVT5ofK8zwiQvsflk7zqxSXAxUYKjFkgql5IFtSC8w=;
 b=UUSxe3NJLLmIApgaXx5GkBeJaNMHr7bSNKM614yCy+C3BB9RFjpaBNAOSmXHLYDjG69ENhXdO
 JAbwv86STRHCcOZ70kNRZ5XKWhyNLI+BqvFRcgF4VJp7eKEawB5RW+D
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEwMSBTYWx0ZWRfX/f1VytfR/aDX
 Em6O5QaVX0sqVMP6mq63dVivd8nISyRtaCO7UW2E3Fll2wVO89PjMi0zDxlZby6F9Mce1u1zvT6
 Kk3LWlXG+J9RQ6rxcwAaMrtb51v7n5Cy4qcTxz8DPkYs/fPH34fKQgJp95AJLnPUMt+qGZ3b5/0
 gJ8A2FuQkHRwBTTY16MaMj63Pls7/qfNfqxmXm1N5zNXJMXiXsaIO9lkHwPde0tObBUlG2/1h+E
 Ld/9Eiz0BFHrAOY4LTKPVinGzW77WWUSBgqPQ3pEgoDvzQgYSHvU4E/5tq5JG1rHgdPmCJiW2gV
 KJD9pYfubd5cSJ2WHuRiCsgCfGXhshgmBOm0W4dR3I7zx2Pv6MFKWL4tfJ0ea3E5Xodyh4sv1cT
 pQv6VJVxQ8yxkKNg7OODqzo9EeY4wjljtYmufz8Li7goGvLD8IQTU4Buso2tdfUznTKj+Z1+pbe
 3TM26AZ5r1H95+i0Iow==
X-Authority-Analysis: v=2.4 cv=Lv+iDHdc c=1 sm=1 tr=0 ts=6a46349b cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=EkeGX7dVun7IgMBPpHMA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: cuI5AypFqIbZ3Kgf0t1fokwBz-11tJ_U
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEwMSBTYWx0ZWRfX50vfi1JURtXe
 EyzQAdLdGnQe4Pm9asnmqTQRjVP2OeNh9sRbFetsPsJaGYf1YJ4hstgxBWvesRCwGyYytEaeDuG
 WlZn/0ov8NJouNunriExElnjvXrExD8=
X-Proofpoint-GUID: cuI5AypFqIbZ3Kgf0t1fokwBz-11tJ_U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020101
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11950-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:krzk@kernel.org,m:djakov@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:komal.bajaj@oss.qualcomm.com,m:vishnu.santhosh@oss.qualcomm.com,m:dmitry.baryshkov@oss.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,qualcomm.com:email,vger.kernel.org:from_smtp];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 275C56F5E3E

From: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>

Add SMP2P nodes for the cdsp, modem and lmcu subsystems to enable
inter-processor signalling for remoteproc state management.

Signed-off-by: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 69 ++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 26ae21d4c7e3..53dddf35963e 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -428,6 +428,75 @@ lmcu_dtb_mem: lmcu-dtb@b4702000 {
 		};
 	};
 
+	smp2p-cdsp {
+		compatible = "qcom,smp2p";
+		qcom,smem = <94>, <432>;
+
+		interrupts = <GIC_SPI 263 IRQ_TYPE_EDGE_RISING 0>;
+
+		mboxes = <&apcs_glb 6>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <5>;
+
+		cdsp_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		cdsp_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	smp2p-lmcu {
+		compatible = "qcom,smp2p";
+		qcom,smem = <617>, <616>;
+
+		interrupts = <GIC_SPI 287 IRQ_TYPE_EDGE_RISING 0>;
+
+		mboxes = <&apcs_glb 10>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <26>;
+
+		lmcu_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		lmcu_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	smp2p-mpss {
+		compatible = "qcom,smp2p";
+		qcom,smem = <435>, <428>;
+
+		interrupts = <GIC_SPI 70 IRQ_TYPE_EDGE_RISING 0>;
+
+		mboxes = <&apcs_glb 14>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <1>;
+
+		modem_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		modem_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
 	soc: soc@0 {
 		compatible = "simple-bus";
 

-- 
2.34.1


