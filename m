Return-Path: <dmaengine+bounces-9371-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNyNCRk9sGnbhQIAu9opvQ
	(envelope-from <dmaengine+bounces-9371-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 10 Mar 2026 16:47:37 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A57C9253E94
	for <lists+dmaengine@lfdr.de>; Tue, 10 Mar 2026 16:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BF5AF304EED8
	for <lists+dmaengine@lfdr.de>; Tue, 10 Mar 2026 15:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1F13A16B9;
	Tue, 10 Mar 2026 15:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V8oRJsoT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dif843Ej"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8493AB298
	for <dmaengine@vger.kernel.org>; Tue, 10 Mar 2026 15:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773157506; cv=none; b=o50+GpSf5Dqc4PApQ/o+Uq16/PT4I0IZTaqs1FHoDvLCrIEIs49VCM46p23ObpTSD1wQl1iFPOMWI1bGULdlDjEmaonKO+OJSBBsg4dgtRrJUD5FgqAHG0laEbF7eFqabPz0OH3vQ/QkXz55zWWxzL5lPUJU8tM6PHcxc63rQSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773157506; c=relaxed/simple;
	bh=0l3gdVnkPeEhRWmaFMSjmRRcTqey535uYCWAXzuHtwc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oVkoMD3HtNy74G/woeydM0YdQvXI+SkoYnduIkkU/0CN8odA3Vdh5YBznL/bnmwREX4ISiveRD1a2NRe/0RsJGmdKjqyIPTpD0UHGYpDbDM7xBVELMvoOos4rEI6eT99ceRW0D8JFOOw9OBOMp7HDXFscGpTwQKeWbBZxqspaCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V8oRJsoT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dif843Ej; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62ACaWrN789269
	for <dmaengine@vger.kernel.org>; Tue, 10 Mar 2026 15:45:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bP+u/9sMDsi5B9HZu73nJnAW0uvD7B1160U6L0iNO8E=; b=V8oRJsoTrmUec7Cl
	Nhf21RUxYttu5cmPgUVMt2Z8NuESdP7FosY8Xv1NI3BvaTNeZR13EJrBHmJp5iHE
	nX7DCnXrAyWzR3cA+2eeY93q+OeFMmcGMblo/NYI1sDJ5s4EXiqC9JPr6bCXhrJz
	veCIk42z9ki9gbAvw29OsmuIwUdJOmuwP82jU+nC9ZpAy/n7JBvw8CNrliViKd35
	8Mv9hfGxyk6YbTNgKUWOCnYF70ADyMVxd/cORXG9XoE7IiSUVsd1l2yxan1He7LN
	yeM+MWfPx97b8DFwg+FCg4XyHq1kiNzqKEmZe0VLEBx1m7yVx00kNXujyv7chFXF
	QVKRlA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ct1ekvkp6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 10 Mar 2026 15:45:04 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cb0595def4so8832685a.0
        for <dmaengine@vger.kernel.org>; Tue, 10 Mar 2026 08:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773157503; x=1773762303; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bP+u/9sMDsi5B9HZu73nJnAW0uvD7B1160U6L0iNO8E=;
        b=dif843EjEWq9kMcaTBPn+oqz8V1/qFT8Xx3IFHG9c5TiU6Twmx83po93dYG1BJBY7F
         Zk5PYJFCVDKiQk+z3uEgrwLzJBJ21vnSFU5t88E42YBpeTIct1Wtm5o7dU9fXUZ2RGAP
         tFFnDO1dFOnWleqAnY1Lr9nEFkf27VfOA/p3qQXUVhGHOVlw5cw7ltzdpvtidepqAKKa
         FMnpdG8kkuhXmYqJzM8ISpXFAlUeqqD3GLcxyaJj2gzilkA8L33GSstkWPYS0qEck0cm
         bx/eXHpcijU6H58DrguZHbJ+05JXNXK808bGT+z/Pjf7DobfHX4rHVVwa/FxjtDiucfw
         hqkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773157503; x=1773762303;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bP+u/9sMDsi5B9HZu73nJnAW0uvD7B1160U6L0iNO8E=;
        b=qBLVaXBwtg9Fdl71ACiJZMTMVj34EUCyo5oTEOUACCNKxVxK+w+C0uqN7BGDqIOsKB
         Jem86ALeCLPuArA2F6VljiMZU+szjAonAZoSQ9bnlFdu6q1Jc1cNZHkG72QR/+wAVAGZ
         ZmCNvMzQeNEGj+hJsbAeURE7luXhxE69f6fMyA+jASyaFuAVDZ8WArx4MgsW0SzSSUgf
         jUd4pKndaAIaRbBGYNLPeTSFNBxHpYIK4jf/S6fIgEJ4ABI2CU7ji0+HsC88TrAS5O4j
         saYtKpi6jzlLydXvP4lgPL9VnZJsrEKtLFrRKuAnxjpe+56+hHo0zOt9zXLeTZrIjFjg
         erfg==
X-Gm-Message-State: AOJu0YzIE1d0cjISG3pPJAlbbLHTyFgoKQeN37cpnYshBSH39jMeEEfz
	fLJGDgGkejAlKS2wsQkhN3lHnjndZv5r59vFxFlb/C7I3pJtvILp2E8SntoIaBkoW9QdBMXIyri
	CQtUNNNzpdTtaaXNskf7OnycCu9YZg5t6rIRDYCzyVBvBALTsMrSgx0F1GCgpxos=
X-Gm-Gg: ATEYQzyef5es+FajQGzN9tALsw0Ra7uo0w7ZdexBUouX2vNJHXv8ZIxBrQKzMCH5bXu
	YrBTd0rKceYAV/WiWo1eBCZHGQwKegKHhnqM2a24Wt1VF5LCC2A9qaxgFiQ85h1fXaGa+iMSe/w
	Ma8yNSsNOaqm6eYLVk+HZG9bwz5BzxVYD1eDeNShVG8erZDmFSWT6Iu/H1uvyr5+QVD4LwtaP+R
	ZRPTeF4ruh7XRw7DsBkFalKUOucOzkhyy8O4KQvK7jBUvQy8BTLy1cfY9Gku+UC84pxLy0WvqoO
	mgE48rFezR2WW5gY+Ksy2rc3re0XJmoP3TuGbMpueu6i6nVYCKibNkDQFKcCRYSCUxqVCGGcPAp
	AnhQ4hH45Vy011erC46NTlmpqoDNFp/GsIIebZOn1Q4+IeFvC1rso
X-Received: by 2002:a05:620a:4049:b0:8c7:3ff0:d472 with SMTP id af79cd13be357-8cd93b759fbmr440042985a.15.1773157503299;
        Tue, 10 Mar 2026 08:45:03 -0700 (PDT)
X-Received: by 2002:a05:620a:4049:b0:8c7:3ff0:d472 with SMTP id af79cd13be357-8cd93b759fbmr440036385a.15.1773157502595;
        Tue, 10 Mar 2026 08:45:02 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:47e6:5a62:7ef7:9a28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8d968sm35991600f8f.6.2026.03.10.08.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 08:45:01 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 10 Mar 2026 16:44:23 +0100
Subject: [PATCH v12 09/12] crypto: qce - Use existing devres APIs in
 devm_qce_dma_request()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-qcom-qce-cmd-descr-v12-9-398f37f26ef0@oss.qualcomm.com>
References: <20260310-qcom-qce-cmd-descr-v12-0-398f37f26ef0@oss.qualcomm.com>
In-Reply-To: <20260310-qcom-qce-cmd-descr-v12-0-398f37f26ef0@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Udit Tiwari <quic_utiwari@quicinc.com>,
        Daniel Perez-Zoghbi <dperezzo@quicinc.com>,
        Md Sadre Alam <mdalam@qti.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Michal Simek <michal.simek@amd.com>, Frank Li <Frank.Li@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        brgl@kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2266;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=azGHQ+ypZ4Lhe2NPlFIx77n1JCkKbs9Xx9/yXH7ccEw=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpsDxoASiICoA9hleQ5opj9eSOBzzMms4wrV+Dg
 aMURjFNjU+JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCabA8aAAKCRAFnS7L/zaE
 w0P0D/4/AB/FkYe92/SLONU3+Sd+/cg7ssbvxxZ4YdW6TzgTD5EPbsXwa5V2U8eZptNsSES7W9i
 bOkRPDby+BLPHUq7wSC0wakdBUWSKs8N5Q6CW1vps1Ycdqqygj7KMLNzggMIioK4sGABSYx2owS
 jf1uRNQTx5aKiW/+tNGz/4YVdDR7VMCoPBTucnrazXqWgbiAIuyJKT09gfXxRdY2THAh/fZtcbQ
 kPJBKUNdPH4hbxX9LXCT5OH7ugnMkQ8yTvHbaKSecBSFqP21FlN06d1WBYq53O+4f+4eWcCZ0V0
 7cXs1o24/VQQWflsWPim7hIs7OLhMd/N38BrCEA0FCGp6b7wBmdmq+P8soN2NwTcySK344MIf8M
 /zJlHydGUfxRQmtQL4e6Tb396QmW7oAs8+6wG0MHQ+dakS07vZX2c4bIxYkO4QN54uSvg8KnGIZ
 XEj/1ujU0LOFJxRNL+w9pr8FuwhJn3X8qGPDDtVsz/Fgmv9ToerLZgFIArY5zyTsNQatpA+NoA7
 qbbudbHqRdtuwrKQ3V13NBLhKmQyjGAFD4gVJpDJ9zqijBCrm5+7P5xm1zUKNdAAUFnZyQSndG7
 SjMqnZgClxvoCe+efbb64GpY/S42RZZVmOZ9a9bd9TdS6kdAgnnIIn3OnUrWhbCVgZQhs8C+UPi
 3I+FPzpjDlQMscw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: d4uscPy9toeyX26ATamvN16g6tyDLaWW
X-Proofpoint-ORIG-GUID: d4uscPy9toeyX26ATamvN16g6tyDLaWW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDEzNyBTYWx0ZWRfX/heXkA2+9EDD
 AOWbC2S2tjHalBi0j+cxIarsqCPTawe1iizmYICA/+loa92JT+pgUgns/ZWD6Kgvsy6G8hH8Zmv
 QGaJhkTyl4XoN8aDUEp+mGGUJbD8QL6GAjFH7tXkFsYQWptEfsYnL3DtVr28SAiQ7gyFILE4nWl
 knjYtDJPqC6xuNKozUyA4bw8e6lNUtFBawADXYDvCqlv20LUlMhhpXxo0x8BAxDLeWNmr5QzpFj
 4ZeAPquu5EyqDmkpCXOlFVsfDRx1IZBio9/sYnrsq5dWXkek1L4n4/urvdHMxSSAVvyCL4Upgl6
 ONfvTVDtRaQIOoiMrGkUpVcFydggOTTCYr0LVqKWutt04otyYHiDsGNcrfqYAj1b9FLYVbM0ZWg
 nRTQLDXQumJKUwPb3ppGhYGe4EzqjqEZleJ575VrROS/iZDDEKfsBC42bwP/HX/QvxULAsI1VJq
 LhKW2MnLHHwLjgj6P4w==
X-Authority-Analysis: v=2.4 cv=eIEeTXp1 c=1 sm=1 tr=0 ts=69b03c80 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=r78XHnC5kAO70zNBxnsA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_03,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100137
X-Rspamd-Queue-Id: A57C9253E94
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9371-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,linaro.org:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,amd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Switch to devm_kmalloc() and devm_dma_alloc_chan() in
devm_qce_dma_request(). This allows us to drop two labels and shrink the
function.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/dma.c | 39 +++++++++------------------------------
 1 file changed, 9 insertions(+), 30 deletions(-)

diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
index c29b0abe9445381a019e0447d30acfd7319d5c1f..a46264735bb895b6199969e83391383ccbbacc5f 100644
--- a/drivers/crypto/qce/dma.c
+++ b/drivers/crypto/qce/dma.c
@@ -12,47 +12,26 @@
 
 #define QCE_IGNORE_BUF_SZ		(2 * QCE_BAM_BURST_SIZE)
 
-static void qce_dma_release(void *data)
-{
-	struct qce_dma_data *dma = data;
-
-	dma_release_channel(dma->txchan);
-	dma_release_channel(dma->rxchan);
-	kfree(dma->result_buf);
-}
-
 int devm_qce_dma_request(struct qce_device *qce)
 {
 	struct qce_dma_data *dma = &qce->dma;
 	struct device *dev = qce->dev;
-	int ret;
 
-	dma->txchan = dma_request_chan(dev, "tx");
+	dma->txchan = devm_dma_request_chan(dev, "tx");
 	if (IS_ERR(dma->txchan))
 		return dev_err_probe(dev, PTR_ERR(dma->txchan),
 				     "Failed to get TX DMA channel\n");
 
-	dma->rxchan = dma_request_chan(dev, "rx");
-	if (IS_ERR(dma->rxchan)) {
-		ret = dev_err_probe(dev, PTR_ERR(dma->rxchan),
-				    "Failed to get RX DMA channel\n");
-		goto error_rx;
-	}
-
-	dma->result_buf = kmalloc(QCE_RESULT_BUF_SZ + QCE_IGNORE_BUF_SZ,
-				  GFP_KERNEL);
-	if (!dma->result_buf) {
-		ret = -ENOMEM;
-		goto error_nomem;
-	}
+	dma->rxchan = devm_dma_request_chan(dev, "rx");
+	if (IS_ERR(dma->rxchan))
+		return dev_err_probe(dev, PTR_ERR(dma->rxchan),
+				     "Failed to get RX DMA channel\n");
 
-	return devm_add_action_or_reset(dev, qce_dma_release, dma);
+	dma->result_buf = devm_kmalloc(dev, QCE_RESULT_BUF_SZ + QCE_IGNORE_BUF_SZ, GFP_KERNEL);
+	if (!dma->result_buf)
+		return -ENOMEM;
 
-error_nomem:
-	dma_release_channel(dma->rxchan);
-error_rx:
-	dma_release_channel(dma->txchan);
-	return ret;
+	return 0;
 }
 
 struct scatterlist *

-- 
2.47.3


