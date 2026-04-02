Return-Path: <dmaengine+bounces-9861-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kE8DDt2FzmnuoAYAu9opvQ
	(envelope-from <dmaengine+bounces-9861-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 17:06:05 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D424D38B05D
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 17:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B2FA30C60F5
	for <lists+dmaengine@lfdr.de>; Thu,  2 Apr 2026 14:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682EE3F0A81;
	Thu,  2 Apr 2026 14:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fnAEDssy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IyNFdDlD"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21EE3F074C
	for <dmaengine@vger.kernel.org>; Thu,  2 Apr 2026 14:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775141769; cv=none; b=kValhi7+VqI2R/gDthYKLLKDLanjd/NTlJjyLG9cp0qnuHIqkFkJRXszwxaa3CFqTPZwTasTFfPxON7JgV0lhLmJPqimCIkStJDq68fzTYkQ3WyRhr+q2faGONCnDEqDcwulroRiwqj+f/U/q+A53ABSQG18l/bzr6bHvTFIBYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775141769; c=relaxed/simple;
	bh=6dN4XjHr+6OQnOzxmGwMll0VZH7PW0q5aNlxk1E5+Hg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Owrt4zjqmcMyBvD4OesC8BaeAcG/mskk3XdjGOQKs7yQWKWm15mGRG1qQIo40NEglNYgadPGEg6UAHCXkcpZV/rD15HHVrt9E/H4brbeqMp7EgBQ1tcDd4rhEtUSBKgoW6f63i/q4j9k2DQ2pazTSW8dUgbtfSyDrLvvK5Iu5sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fnAEDssy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IyNFdDlD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632BtV0V3238871
	for <dmaengine@vger.kernel.org>; Thu, 2 Apr 2026 14:56:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9iGVNuTYeeAltbq14HNN1Bd2g5XTMHQ/MFj6N7hyZ8I=; b=fnAEDssyNLp3ghhD
	f25/maqd1A+1r1IMow5HxZz/DPatB5OjSKm/mmd+91kbOhUstS22Az8SuZPumI1v
	1vsfNL9zjpt9rK/2Qf9OIsVS8nbFK+ZbMk3UfgPu+tafBQ9zDZSFlzedv0egIWD1
	XaXCo/gr54EU1KiqKRlDIut2Ecf91D3q//fnIIB8LkyZDsij2K8D44LGT7x3mMl3
	B1L8IqZdBb01hikGg6BM4UbmqrF3YqyP6A04or+xKwyjek+MgimeDG2wG3g3+iK4
	GRquod6DN6hSJavBLdBwhrbQ5j/1goF/2ZfhxaaYy37iNkzIdWYATZ7nx5pikEKB
	Bc7thA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9r0u0r4x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Thu, 02 Apr 2026 14:56:05 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50d5d1c2289so6530111cf.2
        for <dmaengine@vger.kernel.org>; Thu, 02 Apr 2026 07:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775141765; x=1775746565; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9iGVNuTYeeAltbq14HNN1Bd2g5XTMHQ/MFj6N7hyZ8I=;
        b=IyNFdDlDHzxY5egKAoGOE0eGdm1zeZDnEsydRJqp3cEmu1reCgxWSDuTPQPbJ8xBSi
         PP3ehw129+Uusbw4gP0sYtStNxmMdn5ieP83uD2WCMHPTKe5jNBK724hISKmqh5vEQmE
         YqmIYTLDe0m6ZvkSg+D2yHmo4RietaM10lfGqAafNCgAZkMsr/udAMgQckHYStVKD4vH
         TVdTrcsp/l6gAJPcJEYjStbJ+YItZ53RkuC91YCXjNu2LhPZ9xJXWEJ+qbJPPT9WvanT
         8zh0K8TS5xcP0Ezm+HbNkhGYEGP2TrWK9aG8OZEI3FBhPb7RQgzTS/qLuu+xiXOerdHw
         wF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775141765; x=1775746565;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9iGVNuTYeeAltbq14HNN1Bd2g5XTMHQ/MFj6N7hyZ8I=;
        b=F0t9PfniTNnHDMbV0h6ZSUDh7299iybJ5XnSFTiCig/f0SYMUsZRExNmTj3fylsYJY
         9tlMj+h2HHd+BRJZL5dnO5pTSGli2THRAw6f5wLnXZIhqPGOIrix8dIqRsRHezFspk2A
         P49nfzoQa55ObKUCChvsdkdEli6Q9vpfIghTjbQRycRt+hCGpZGkMkka2EXL/c6S5iD0
         +PS8eFzK+VuLZV2OlyfNl63fQEvz54orelzGs+HoOyWORgbd91HdCPNb4Wn/oW8hhAqo
         SIQZy1hkPzisLY22vlN+Yc3kXQN/oJ5SKtosjX+P0SO7hF8NmceAstxQcrJCbWGMkbeY
         g4AQ==
X-Gm-Message-State: AOJu0YzjT4qbAX1HIq9R5Zh1i6PeC/GpAThir5UwwG4z0vFJqd5MLQjv
	QMksy1OhA3tC/CZMrtzH/JpOe4ievhLpZ5sHrh80siTOBdLcTX5qwlUsv0Sl7wWE6yeKvorLkiO
	VTe/uZsO+DOhfay2nlMnoyj+3m/pxJeOuEnnLGlVH2M5Bj1T6Ezv+8NEH3Gryh8U=
X-Gm-Gg: ATEYQzy8J4BvbdqND38YbtDqdHjz60OrlGu+rJdxCe5UmKccPFbqKJD4il1ke8tkxZ4
	3E8ZdxgSe5GIcz7NSnSv3M61rCrOPmoplkX5vp+UG4t0IwZv8yvw3zPf4mKJ3CriUggxvDiiJEQ
	NVL3TJpguVaBXaAyYGagnFluclIj7bK+HSmmTWc5dsj2aE4g2DXWI10TiqEKU3ooA6G7KZEJxKw
	OrEBURBbYq2b5o8c4LYwuF9EegE65rpRZLnWWyPQ2S4gv8RZ4NFH3aOxyGbVaHmMifQccdVnQNa
	lpg3lfaCCzL8xx9iEU3wV5laNxJ9s2oE2e1GeghyXMyUQ4tt0xLJwcMsG2kKU5B2DGlZHE0ptkr
	S/Li27YL6O7aXqhHxdBWgu3ALf/n+poROUoU1HpqGdnN7xvwFS/Qh
X-Received: by 2002:ac8:580c:0:b0:509:3cd:b243 with SMTP id d75a77b69052e-50d3bbddfecmr105597381cf.21.1775141765114;
        Thu, 02 Apr 2026 07:56:05 -0700 (PDT)
X-Received: by 2002:ac8:580c:0:b0:509:3cd:b243 with SMTP id d75a77b69052e-50d3bbddfecmr105596981cf.21.1775141764680;
        Thu, 02 Apr 2026 07:56:04 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4ff1:3e57:22ec:dadc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4f5294sm7234038f8f.35.2026.04.02.07.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 07:56:03 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 02 Apr 2026 16:55:18 +0200
Subject: [PATCH v15 07/12] crypto: qce - Remove unused ignore_buf
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-qcom-qce-cmd-descr-v15-7-98b5361f7ed7@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2012;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=DfH5Bb+Cx5AadRW9+jaH1GcMtyO0VLpMWlVREcJBr7o=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpzoNyFx0Etnu2/7Xen0gWpBFZ1ieiULMMRmf0H
 dTMlK6qKdeJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCac6DcgAKCRAFnS7L/zaE
 wxcyD/4hXcbTkC8LIp/lwCB+yEZJEm/+U6CMtxj0z5MXytldDhzObBweDdkesDvi2TH0bZnhx/M
 QAEDeB7fy3n4n97BktwVseoItXlZ2bj9ipNnLEymN9G6ze2aZKXIkQ3ANRQpc271S/pz4R8pD1U
 XMip2W2kAz8R5+2cygpnjwYHhCIjXYuK7piExHs53IaUtpqWgdpUYsbQr7h6bu/Kjsu/jMUpiEJ
 TnnF0JEkuAGezCa5beyxU6YL8kMaFVT7h7Vg7x0RYQKu4G97cZAVX/zMY5rJVWsj+EDoao+lUvM
 wD+nv8o+kyD3Ikj2lfUVY2AzLMMANjOQWZuUaUihp0iVfh5uX3Oy1gBAT25PWFcUGX4n2C6oD9d
 o49niLg3vR2qIVQCtghh2fx2Wl/palGRNaDucuTAzrXIS6taZ6WBx160n5jodW+R2AqO86pnudI
 tUqBye1okP3/9ucTEBmRQsu3W2WpNCWHpjvLZH3qYVEXveiWZ58AfRRdrpmopJ6wb1z4aKMpq+z
 94a45xjHW/dO6ffUlFz1HLxAi4BvPiWd9n5Bo83Y9eY/W1wwQsSjUpRRLhtkgK2A8AI7hIVzYzA
 +pLL16n9HNqW5r9ginpaVJg1RR1v9VIk1mWRFnaQ+skPc3e+DMDwSqO2BSRLREqo4qXE5S+4GHs
 BjTGf2SKCagZs/g==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDEzNCBTYWx0ZWRfXzFhiJ/KkJDNP
 pqIe9baWKBb1+nGcFvJ4UKsrxHsxVD8yys1iiR8sdshA1ZtiMazIbeUmsGINRT7huUsv42V8Ov3
 OAR8In2DpRLeWXVIl6sniEkJX3tcye0gPpd0wkFcBpYJJV9JXXZYnFqhTH+3E7haCc7cLR1+FGB
 p3OmR6unXAVxSs7vq3+6SOvRPwdWbLip40+lT6N3g5RGcIA//TV94VbyMIyaP5wegOBlelQGWUK
 MdwWpGpPGRbqH2uu8h2H8XI8eyrVzkJcFOzbBpwpcqwKXBFomsVmQyONwpC87bWNS6Ifqhz6R5X
 hw0ipXEAhKNgzNdx8dMuexg3ksDG03qCG5UZSVPWKcV3VVY3U8ZEBZiXIixKz6sdAE3tHHh0tqh
 LLO0s5F5phKBCQfL9fe/CGLweYvALfMwp/QCcBKnTHcfzXR7NO+SSyk7xvMsGj6dmA+IX+sbdDO
 H7Kf0BMtyU9D/MgIl2Q==
X-Authority-Analysis: v=2.4 cv=D5xK6/Rj c=1 sm=1 tr=0 ts=69ce8385 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=tWRRbWwrKX-5tUpmLDIA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: NyPzPNq7flgT00o8H8AI0iYH-AIQS4zz
X-Proofpoint-ORIG-GUID: NyPzPNq7flgT00o8H8AI0iYH-AIQS4zz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_02,2026-04-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
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
	TAGGED_FROM(0.00)[bounces-9861-lists,dmaengine=lfdr.de];
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
X-Rspamd-Queue-Id: D424D38B05D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

It's unclear what the purpose of this field is. It has been here since
the initial commit but without any explanation. The driver works fine
without it. We still keep allocating more space in the result buffer, we
just don't need to store its address. While at it: move the
QCE_IGNORE_BUF_SZ definition into dma.c as it's not used outside of this
compilation unit.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/dma.c | 4 ++--
 drivers/crypto/qce/dma.h | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
index 68cafd4741ad3d91906d39e817fc7873b028d498..08bf3e8ec12433c1a8ee17003f3487e41b7329e4 100644
--- a/drivers/crypto/qce/dma.c
+++ b/drivers/crypto/qce/dma.c
@@ -9,6 +9,8 @@
 
 #include "dma.h"
 
+#define QCE_IGNORE_BUF_SZ		(2 * QCE_BAM_BURST_SIZE)
+
 static void qce_dma_release(void *data)
 {
 	struct qce_dma_data *dma = data;
@@ -41,8 +43,6 @@ int devm_qce_dma_request(struct device *dev, struct qce_dma_data *dma)
 		goto error_nomem;
 	}
 
-	dma->ignore_buf = dma->result_buf + QCE_RESULT_BUF_SZ;
-
 	return devm_add_action_or_reset(dev, qce_dma_release, dma);
 
 error_nomem:
diff --git a/drivers/crypto/qce/dma.h b/drivers/crypto/qce/dma.h
index 31629185000e12242fa07c2cc08b95fcbd5d4b8c..fc337c435cd14917bdfb99febcf9119275afdeba 100644
--- a/drivers/crypto/qce/dma.h
+++ b/drivers/crypto/qce/dma.h
@@ -23,7 +23,6 @@ struct qce_result_dump {
 	u32 status2;
 };
 
-#define QCE_IGNORE_BUF_SZ	(2 * QCE_BAM_BURST_SIZE)
 #define QCE_RESULT_BUF_SZ	\
 		ALIGN(sizeof(struct qce_result_dump), QCE_BAM_BURST_SIZE)
 
@@ -31,7 +30,6 @@ struct qce_dma_data {
 	struct dma_chan *txchan;
 	struct dma_chan *rxchan;
 	struct qce_result_dump *result_buf;
-	void *ignore_buf;
 };
 
 int devm_qce_dma_request(struct device *dev, struct qce_dma_data *dma);

-- 
2.47.3


