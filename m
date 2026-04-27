Return-Path: <dmaengine+bounces-10133-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFiBLzsr72mb8wAAu9opvQ
	(envelope-from <dmaengine+bounces-10133-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 11:24:11 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDC646FDA4
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 11:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E11C301F167
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 09:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1103B27F0;
	Mon, 27 Apr 2026 09:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gtJe9AdT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BFnjTGYb"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1563B47CA
	for <dmaengine@vger.kernel.org>; Mon, 27 Apr 2026 09:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777281380; cv=none; b=TDS9Da4Qf6P9FLaFCUNyEpp2HIzwxLv+cnFeLOmanKTp5EPRTa6jtTc0iMtE+Iu2t0dQaG91Ltk9xiT4LFNOjbay94GlMQw7LHZCsE0yufE5TVmTV0FC+TmOPjBJxkM/RxCEF25AJuEHxhSUn/9QRKDs2C0QgLgRj+OuyDdcM+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777281380; c=relaxed/simple;
	bh=0l3gdVnkPeEhRWmaFMSjmRRcTqey535uYCWAXzuHtwc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aMmqg8B0IsXptaTrtLh5ACi8vsT6BNFN+6/1mg7WaTWQm4RwI8lCtkWVUysvCDS82V9xkbJfxjYWDwEVPugZlYDWsBqKcyfdjUw56HOfvWXUb22IZNXDLNy7LFNxUIkaCOI+zW19b8IZXfo7rt5x2hw6eWPL0U/2WC76ME4tEuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gtJe9AdT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BFnjTGYb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R8TLAp3681853
	for <dmaengine@vger.kernel.org>; Mon, 27 Apr 2026 09:16:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bP+u/9sMDsi5B9HZu73nJnAW0uvD7B1160U6L0iNO8E=; b=gtJe9AdT9HkSr3Js
	x38JeDnFSfFGOdRNOe9+KEzBWFWrmSCTwmi8hAmj/tDuBmlPa8+s+Uag8VjhObGC
	gZhKmcTh+K7bWHbYKAQciZS0kiwnqrVK2uCWF99tCQ/5KLLSPz2MU4kEyCMzekTV
	poy5FOVYLjPaKcLjJibfjF5MgB1Nt91FwrMa1WUeJOIQGcIVm+2nRB8Amo854ERp
	exzBk1gxO7lMyb2AwWrXao/IQx39OFt2gCyYGWSCd2UTSHEAwcYTExvVJZ34qp6C
	rtWWVfBUpY3KcN1n5bG4H3xAl9A9fBw/KlnQF4lYTfz9wksveS/IYMjXelxJkbPL
	vnP+6g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drpsgwaed-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 27 Apr 2026 09:16:18 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50e67a4f642so74775871cf.0
        for <dmaengine@vger.kernel.org>; Mon, 27 Apr 2026 02:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777281378; x=1777886178; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bP+u/9sMDsi5B9HZu73nJnAW0uvD7B1160U6L0iNO8E=;
        b=BFnjTGYbcZ2dxQ6AYvFPgB+QwucO1LPM8FtNdISCofiyV0GIECiasWxpoa3nfZTK/m
         ZgWOFCXHjSbrkNCh2PRmUQ0LuKJb5z/+khIhEpvDihtDJ31PgtyieGf3fvE5H1o4awk0
         1avcJNxvnXbO7QdEX/QDiI/vn6SeW25Ij4bYO7NcuAfJFtFWPqBFmmhg13cMguVtIgab
         qkpSzllZMPrk0k5eK11/c7apYSwo8WUrGNIJ3RJV3JWJQvUQ6u5AybacQsBhl+/3WxUA
         gjeoFkzSrcVJdkPyTn68A5y/LQPb3viVsh69EdEbYJLAtw14kQUM2xN5CWr0nBWenM+X
         Ehaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777281378; x=1777886178;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bP+u/9sMDsi5B9HZu73nJnAW0uvD7B1160U6L0iNO8E=;
        b=gq61GnNRJC9z7nwXTKjG+gXmQay0rDiiUTyltEuUb3p/HiusSg86hT8rTaeyBPhkni
         4xKSPK44B1YatkoW8Oltc6V3yZWP/I8XtJi4iZ8/+bwhjBWFGBjJ1itAcA7Adp4T7SsN
         nhqr94i/u5FWtgTp0d8rLBCXUcMm3TcKJvgrnb7ge+8TFfG0fAY6kUv3illxzjvmDj9D
         9t7UN+O+6TQRK5J+HCy+JWPotJhTR0o0itGOBUr8W9s1rPf3lb6xs39ce/Ky4gtYYuZy
         pyjTopBb6MCOW4OdzwNUuWIXwcd2vUn7Gh7tifEa80qawwni6CkdnpwKTLWeffIlwRjL
         mwoA==
X-Gm-Message-State: AOJu0YyFmxUpSVr2iL0bQJ5lGVl8rcbh8hztv+DtW6+xFA3HH0FUwYVd
	G5SDFLqsdT/4wOgcJvC7uF5P/V0v1fFmsxbX7OA8K2VAI3kaxnQXqCgd1zWO1OD89bqMsLARWpS
	sF+gv5+Y6IlZe27Zz6qPbUKBP6idk7KCY1g3f93JjfuN0r50+CWIZ0g5rOeRxDVE=
X-Gm-Gg: AeBDiesplwZl3Ws0Xoez1g/qyk1hyV/OX7H+es0zMYaC7Db7ZCMSk0lnDUzbxyfweKV
	85nvCdLZ8/QmHkSQR0KoUrw+3iOVLwCgEEr6VPqs+c3l3FUxq1xCuHDT2dmR+yiY4uloaEoyBRv
	NXPnn7CG0mJ567vLhXs0XtIQKqIYQnATTwQ7zKXGXZHd7nJgW3fYrRC7QfnjxGLqxlDA24pN2o/
	NjyqKwRApVpie2C4/sNOUpPsOXG8RRWr5ubklw1mWVGgOie/cVntQQuv3IuBob2pJtTIT6jgli7
	O1h3evW/vqHJFwnXeWB3k9HlveNLgne+H9puPsGyo7UwFjCNJSSA9BS6bkJ54NrdmYGRZ77iHX9
	9FLdMf8XcdOSJFyyjGOr0TJjDbJtezOHHsLfHJU34WyE52ogG9V9Ef3Bx6bdipA==
X-Received: by 2002:a05:622a:1884:b0:50d:a644:69b1 with SMTP id d75a77b69052e-50e36ba3f1fmr568019401cf.25.1777281377964;
        Mon, 27 Apr 2026 02:16:17 -0700 (PDT)
X-Received: by 2002:a05:622a:1884:b0:50d:a644:69b1 with SMTP id d75a77b69052e-50e36ba3f1fmr568019031cf.25.1777281377465;
        Mon, 27 Apr 2026 02:16:17 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:5062:ae86:23aa:702c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a6dbfd4b5sm40559365e9.28.2026.04.27.02.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 02:16:16 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 11:15:42 +0200
Subject: [PATCH v16 09/12] crypto: qce - Use existing devres APIs in
 devm_qce_dma_request()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-qcom-qce-cmd-descr-v16-9-945fd1cafbbc@oss.qualcomm.com>
References: <20260427-qcom-qce-cmd-descr-v16-0-945fd1cafbbc@oss.qualcomm.com>
In-Reply-To: <20260427-qcom-qce-cmd-descr-v16-0-945fd1cafbbc@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Udit Tiwari <quic_utiwari@quicinc.com>,
        Md Sadre Alam <mdalam@qti.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
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
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBp7ylFm7c2nvUtUcJ1z2g6SDoZs/iXQQpQZYP/8
 O+2w8pXe2SJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCae8pRQAKCRAFnS7L/zaE
 w0/VD/9baMWDsWkK4NNPbwXnJZguEM2WlDqh5cmEYnMjDW61exw0L221i9YQuxz1FKvSUWB0EXK
 wQZwEczyHis1Ia2k06kvA/lZuUEchbz3qTWQ/lAtk47GtvcvBYl2kFP0ID20FCiSWdNcCGBi2J/
 ilU57jELOOXlzvvmdRZMs3z80vOhTiAyEm7K2zOfbQYopsSb6rd5CGEH7yC4Qy9/7Oga9Mx3cg6
 DAnmBG7pvPKXqq6pJ9OLDJesW3VGWU1r6AGomCIwb6vuT7GRc9fqrkgNDKlfFYh/bBwe5fQI+Ed
 MWV7YAliHyiSA8Sw3O4BTJcUEJBFaBHMTUKyIWy5IZAhXx78RIXWb8r/gf0y2ftoNZqQrjaedEh
 RQayfnx57jEmVr8wBWzN6EEEsBlvvicQ4bmWTb+bX/7KTDrkZ8vB7egEW2Ld/gBB1TGmyFiVezD
 t+CQJf4GyIZmKytis6NvzgKF8R2391RbGCzvQ9RAjdFEUYgMwn5myMfiGAHv1n/uyCk1g4zY9P2
 pv2Wl3qrMSXCX+SKgAqQL1GR+fsP/+xuAIpHw0xb8oaLosSzVaa62s/dP3VHXIQnq6PO33f2qkT
 hXstzncGxDS4N9RodeFwFH8ytChyAtYXC3SKDjjHhQB6D/F20SA2U1cId6UPc1FOPzLhFETzdQN
 ivbkjKgwa0BeqSA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: 96JTZsWs0RWP_eh8AGXqKY0HNalnpL3Z
X-Proofpoint-ORIG-GUID: 96JTZsWs0RWP_eh8AGXqKY0HNalnpL3Z
X-Authority-Analysis: v=2.4 cv=Y+fIdBeN c=1 sm=1 tr=0 ts=69ef2962 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=r78XHnC5kAO70zNBxnsA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDA5OCBTYWx0ZWRfXyQVk4tNh13Hz
 mqobpzpkA/auMB9yvo3TH7wQrYmC1ik+qsOt8Hmb0XkpIVOIyaNNZI8UlRYZQEeFqxoEFASMVjw
 YkS5Mf43NnTiScmIzee4cFlibD+yaqefbJl8PtMnJM7J0fv68x7nIdxPIXC1PVrfQU3nggjxmZF
 NjKs7N4V8z/0o1MGEb0Iy8TFHTWNkdJ4db5uSAENbijJkU0DvcyYPo+6HyEbvwfQL+C4mmDSWLC
 kbzpF8YvOx5TIG2yIStD0CGPam9ihLe6zOWIBxqHW87DZTQMuULFVCnlaD6mYKN+eMjzgYEuJWI
 6ZqPKtutXFpfhp9P6T9m2kqhUriEOxm6MovdgCC2tIRIvNbLjkZtNK5NF0Yosl52SGgBA8ktt6a
 jzeVDG0NcabE5G9PppU6fpe9cAKV5imV+d5umtuQaTytzyyEMz8EhK8v16bW3VyVqSotP/Kxeam
 TqXaOzgteivlwPzPKwA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270098
X-Rspamd-Queue-Id: 7FDC646FDA4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10133-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,linaro.org:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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


