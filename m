Return-Path: <dmaengine+bounces-9862-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBGOIvyFzmnfoAYAu9opvQ
	(envelope-from <dmaengine+bounces-9862-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 17:06:36 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0141038B07A
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 17:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AA1430D443A
	for <lists+dmaengine@lfdr.de>; Thu,  2 Apr 2026 14:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684E53F075B;
	Thu,  2 Apr 2026 14:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jjv/uOZR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="As21ELOn"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0E93EF663
	for <dmaengine@vger.kernel.org>; Thu,  2 Apr 2026 14:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775141770; cv=none; b=uOTG3L0BKkq9x6CYiCQ6DOGtusTNz78BAtivSYmsBKsrYsi7kGX13N9wmVxepVI2HoXf7T4YIqXbaZkKlHJwbZFuQpEOovm3g7y9aukkvZ/xNSuSWpfTq4reYePR3JBJY68zu2Xgwv+4RRnZ+mVLe4da8zPxTGS1gx37azmuCRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775141770; c=relaxed/simple;
	bh=H6RGZzI1m6Hy642I73fornlozWd6x9hkPKo2H6raYsE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Soj+dHZ/zP+aVTR9zNxdMz+O0IKBjLgd8jntLyX6+bFTlyJ7SLIT7mUJa6ZNTvQ3Bnoq3imH9eV2kRnCar1SMmveHsh7HAg9MT8SSDZh4/eeTp3Law8KUbTufFEVjA+1KjFOKK2FomynOSMPE5PhwViv6FRPycS42a1Pg1zkjTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jjv/uOZR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=As21ELOn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632BlNPP2338020
	for <dmaengine@vger.kernel.org>; Thu, 2 Apr 2026 14:56:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DQ9O/WxlrEXbsvKUWZga3GBiGSWqxH7TMX/h6DSnlY8=; b=jjv/uOZRYaHEHoRO
	OhvrWfyx4BPEtoIbYWZlWkxu2wSKKq5KD5Gi2pjxebeX8ic/lu/iJg8k5ZJ7W0GW
	ThM+v/O9nKK8dTO6xq3M0xE7LJo81sIatQujzTxIj7feWdwhLrTyqwePnhawNizS
	KNAzvC4JuRfDfsl0tHL6wZXBmFHVjNdDOTOHIUEBqrfR+UrpDK7TmSxTSIZZ2Ppa
	oNvWy4pqeMD5wMBeNlfa6ij6d4NKlEz97zIc464WoSitEuIZTk4E5Ga5AZs2di+D
	VFjdYKxOv/A9elKh+iLWD16IpJBjlRnbG1q58lF5Ja4hp0J23jmd0nOEPhl9Y7F3
	6+SkDA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9qw08shj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Thu, 02 Apr 2026 14:56:07 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50d5aa81907so8190131cf.0
        for <dmaengine@vger.kernel.org>; Thu, 02 Apr 2026 07:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775141767; x=1775746567; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DQ9O/WxlrEXbsvKUWZga3GBiGSWqxH7TMX/h6DSnlY8=;
        b=As21ELOnLC+pZE1stAHumjkKqPYskxADwPAMic79EE+YeYyC4/LQrjsnRnwWcdM024
         kHerEvDtAUv/aDI04vh+NPw8jGEoRMTTieOr7tFvxp7l/oGgYwApRYZA+aMDfX+84meV
         0n5xVpSp3lX0acIBUIr6oNsDXBtNe9J8SSjqtvi6JjM67Z8p3dWF7mWYh/HHYprrgrh3
         VToja6F1Dpi/ni9x7uH0YxkwMPrGc9r7u53h3UWCqebzj1Yzgt/FpHsjosEZfsCAxQcT
         VGSjqqt333+vy78sdjTlooofCEFC/h0fV/6h7bMbU6PONdhsnCmqrMkUg8lEeLsVOiWD
         2iKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775141767; x=1775746567;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DQ9O/WxlrEXbsvKUWZga3GBiGSWqxH7TMX/h6DSnlY8=;
        b=s0NcffQwfDFmUcsBBIFeV3SqHiWZuWSxulbHsOOjVGXtb826aFIeX8utbEJG6esmlY
         PmlAldoXC+uLsll15xnQ875KznY9hJIJx6+2WA7+bB11uPhoXSiYyYTCGmqFv78WpIE1
         yuu2rBvCb54HPUfMYL12LtsZZRlflTN229Cgo84AiAwYyU2URr3kxOs+nb602DQ+l1GE
         3D8wA6L632jDhqg4BeSNLNkULz4Qy0sfbXfawlD9B3LlkU4cykGEMIJ9/sI8n/X+hFOr
         zNSe2sL4R1XToU77fyzpc6yNTnZjW0iCAJ3mSRw41NdFuceGvDHkwHjGuJVWsfiKa47H
         JQpQ==
X-Gm-Message-State: AOJu0Yz9o3joxmt/9hGDQtqGVTm5KU/m99pp48uJojiznZt3m4Bizim3
	YW0dBwFq+h/rgQXhJBFSIT08dMCH4tA8uV9BfYK9/v3ftegpJg1Jwp36tDhhe1Rtam5JSlsRg2U
	bPQypg2nYzylnog9oPih8gxrGYVmsNAZlzQ1DNpK7Q7jaeW1HbL6qYwsaKJye9jQ=
X-Gm-Gg: ATEYQzz+LUGMi+4bXc7dxaGF9g4H/WqZf3cBzq/aK5pHE+CogRrbzYf0dqG9kiEqgLa
	sNbOYpT5v4Y196dk4Xvoe7Ts6QLJfSBciTbPWayv/yOq45QAhXJc/QIZ11sP0MOvCQ00QqLUIlt
	otMDt8PRJFoTfalBX52iSdgqPotMMGQsDvyFq+Ka1k6EqF4KsNVAAU96JQwz7bP5v5sFHFuiZSe
	B6uRBYV5ThVHYJB8RVoshUeomYLrdJuwo5ZRaee0bdkD8YhTZUd2hh80G8nckWAt9t9ZCJawnnG
	51x/D2aha8SDL86d/fgtpO2jXoMdfaqddLI7LeszeuNluJRgggXnT1LagMfRn27PRyEHpv0OwlZ
	UblsVZ6L8uyyjV9WiXPz5YX6HtTwkv6Dz2+iPpQ7h6JuSuP9STyfV
X-Received: by 2002:ac8:5f91:0:b0:50b:4b2f:160f with SMTP id d75a77b69052e-50d4baf4d04mr52063411cf.2.1775141766849;
        Thu, 02 Apr 2026 07:56:06 -0700 (PDT)
X-Received: by 2002:ac8:5f91:0:b0:50b:4b2f:160f with SMTP id d75a77b69052e-50d4baf4d04mr52062841cf.2.1775141766263;
        Thu, 02 Apr 2026 07:56:06 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4ff1:3e57:22ec:dadc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4f5294sm7234038f8f.35.2026.04.02.07.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 07:56:05 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 02 Apr 2026 16:55:19 +0200
Subject: [PATCH v15 08/12] crypto: qce - Simplify arguments of
 devm_qce_dma_request()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-qcom-qce-cmd-descr-v15-8-98b5361f7ed7@oss.qualcomm.com>
References: <20260402-qcom-qce-cmd-descr-v15-0-98b5361f7ed7@oss.qualcomm.com>
In-Reply-To: <20260402-qcom-qce-cmd-descr-v15-0-98b5361f7ed7@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2620;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=TfRVgyaOMZw2GJQ0rx6WhRl0huHGm4mvuAmz76BcVUM=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpzoNzEh+YYO2lgM0nPb1VilylrWYD8ji10R8Np
 dqzkiNoNcCJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCac6DcwAKCRAFnS7L/zaE
 w/vCD/41OmwoNJ26OE9s+l3CE75toiL58EEROz30ZdgpzB1yIw/FxXJETSElcZZUPvPRTVosG8/
 9xDaMFFaOC8dvOqRDssG8eh6/JxHaq0jdTDr9eGwwTeDSwDRbAWBnkUCcx1oABEfdgC7ah8gIGY
 OTYe+0fz5tWfRQpJv+SlZdAga2y/zhZdbNyGsbjQXpgOC33nfmQGMiHVYwv0zOLwupKafodh/IF
 6ivjWb1x+XbxxPaqnBoxXG+RYHU5fJjrf/mqB6Cfzh8+wlhiJ7ylloc3dNCwgco6hvpdLqYuQ9h
 gAXW6OVmiVv76dk9cdVbeKzER3EZ2rdetKaQkV9AlfZBrpTP9ES9dYOrV30HZozqUQnhqQIBQWD
 BuLtGY85SXuRAG+KL4iQavzfZI/TYWkiwzU133G/9fF4tLXvemgANbyn6ekk1xC4eeio15yBrw7
 7AXpSHUWITHiuJ//peC4tg94NoNIFiCzaWt7hhex+uoVjx85oZN87R1nZ3uP5xfAK5AxX/xnmly
 i0UUOpHCvGGyRjCD+F2BL9elk8YIljfVGcWNDrvCif9WLOYZ4sKdEw20OvQTpgRU0K1Z+R0u2K5
 T71RunrxXWijw9+EMxO5KYsq/ZMlSV5PAqCoibjcRSE7PqPfkD0gQbEDHGPmPGn2L3bXHxVqtFv
 ACG7MfqSknMZSCg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDEzNCBTYWx0ZWRfX2/Z5uSrF8dWd
 fJBV8d/VMhCtGTZKLH1BRf4bSblaPtSyUdvn1fwXHSeneFrOW8DU3KJ04h5LKAF33hNkfW7DjZq
 m8dsmUX+yI/BXDYYMlTuqOPzfpee9JVBcDYTgOpXs0PcHFbL2+GK6ZE9rKmpJjY9SW5Mcdv86sl
 r+K3k1OPlSg5QBS9jUyku2eSxS0OYaEeJwPUxD48M8ePxhl17EL5iy5P49OjL/LyCNhSMhM4TkV
 fkNUxVnMMw5pZ9Dv5ug6/5OaiFXNFcss4b2iJvY7Npw4HGMguP4dQmxGipSflOp3AehzHI4s0Yb
 BiAEWh4BYDdgtdKONnC/2rOBRkmhsfsdYh9oHoodZuMiG0ySgq72Se3/ov9P7jJv46kBl2/KnXB
 ht9idMZ9LA2tURTguU5L9Rt1pSAlo1HbcA1mBZuaIZCImLgIM3qiLJmuYhjPE28XfSLjN9Ly75X
 w2UAZQ1vcRX/EGA56Jg==
X-Authority-Analysis: v=2.4 cv=PNICOPqC c=1 sm=1 tr=0 ts=69ce8387 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=KrkfD191a8oFwBap4LAA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: KVcvDTNpPbEq-kaYTqyd8zenJhWIoo0T
X-Proofpoint-ORIG-GUID: KVcvDTNpPbEq-kaYTqyd8zenJhWIoo0T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_02,2026-04-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020134
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9862-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0141038B07A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This function can extract all the information it needs from struct
qce_device alone so simplify its arguments. This is done in preparation
for adding support for register I/O over DMA which will require
accessing even more fields from struct qce_device.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/core.c | 2 +-
 drivers/crypto/qce/dma.c  | 5 ++++-
 drivers/crypto/qce/dma.h  | 4 +++-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index 65205100c3df961ffaa4b7bc9e217e8d3e08ed57..8b7bcd0c420c45caf8b29e5455e0f384fd5c5616 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -226,7 +226,7 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = devm_qce_dma_request(qce->dev, &qce->dma);
+	ret = devm_qce_dma_request(qce);
 	if (ret)
 		return ret;
 
diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
index 08bf3e8ec12433c1a8ee17003f3487e41b7329e4..c29b0abe9445381a019e0447d30acfd7319d5c1f 100644
--- a/drivers/crypto/qce/dma.c
+++ b/drivers/crypto/qce/dma.c
@@ -7,6 +7,7 @@
 #include <linux/dmaengine.h>
 #include <crypto/scatterwalk.h>
 
+#include "core.h"
 #include "dma.h"
 
 #define QCE_IGNORE_BUF_SZ		(2 * QCE_BAM_BURST_SIZE)
@@ -20,8 +21,10 @@ static void qce_dma_release(void *data)
 	kfree(dma->result_buf);
 }
 
-int devm_qce_dma_request(struct device *dev, struct qce_dma_data *dma)
+int devm_qce_dma_request(struct qce_device *qce)
 {
+	struct qce_dma_data *dma = &qce->dma;
+	struct device *dev = qce->dev;
 	int ret;
 
 	dma->txchan = dma_request_chan(dev, "tx");
diff --git a/drivers/crypto/qce/dma.h b/drivers/crypto/qce/dma.h
index fc337c435cd14917bdfb99febcf9119275afdeba..483789d9fa98e79d1283de8297bf2fc2a773f3a7 100644
--- a/drivers/crypto/qce/dma.h
+++ b/drivers/crypto/qce/dma.h
@@ -8,6 +8,8 @@
 
 #include <linux/dmaengine.h>
 
+struct qce_device;
+
 /* maximum data transfer block size between BAM and CE */
 #define QCE_BAM_BURST_SIZE		64
 
@@ -32,7 +34,7 @@ struct qce_dma_data {
 	struct qce_result_dump *result_buf;
 };
 
-int devm_qce_dma_request(struct device *dev, struct qce_dma_data *dma);
+int devm_qce_dma_request(struct qce_device *qce);
 int qce_dma_prep_sgs(struct qce_dma_data *dma, struct scatterlist *sg_in,
 		     int in_ents, struct scatterlist *sg_out, int out_ents,
 		     dma_async_tx_callback cb, void *cb_param);

-- 
2.47.3


