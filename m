Return-Path: <dmaengine+bounces-10130-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4C45NZkp72lE8AAAu9opvQ
	(envelope-from <dmaengine+bounces-10130-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 11:17:13 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E7646FB56
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 11:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 98E50300615B
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 09:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23DA3B3BEF;
	Mon, 27 Apr 2026 09:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R+v7DjpM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fzpaYRHd"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328403B0AE6
	for <dmaengine@vger.kernel.org>; Mon, 27 Apr 2026 09:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777281373; cv=none; b=I3QuYIQ42on8Wj6iYuif6/Zp/O6iXPIu9d5sdA/SIJ1Jp7tlBLRUfps7QyBfBFJzxKvTcb4ZmgCzsaWIWysmYBSnx2hCxJ2A4JgMEHqJBiBxwd1BvLwAxS89eyGZMuM30WvR/znbzvIkzfpKWUQFp8TklvIKrnd1Kh+ctzcSgfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777281373; c=relaxed/simple;
	bh=D/DbbvsYNV6WfJJN+Y3qtsfzsdueJP3Q7cdgK44aCk4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DZ4tqtEVlVK/SxaE2ImUZqhp+qKwBAZPh+A2CmpYiHemYKLjYqY4QHouUf1fOSxuPGDZzS9YN9jbb06uhxDzGT3dfYYzdW1R1RsnRlNLQ8dB++Prg/djosuce3LASOeDTNro9p26gq1LdNv+38rxD08lDE0VN0s2RwYyzraIDxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R+v7DjpM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fzpaYRHd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R8TE7w665693
	for <dmaengine@vger.kernel.org>; Mon, 27 Apr 2026 09:16:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f+eJOMoesWuzpXTSR4Li0Qt2PYtZi1rSvrjFdAlx9Tk=; b=R+v7DjpM08+VfYYe
	DvlbCzMwrLEpzHZnl5Al6qc0t40P97FFU6xI/9E4QoAq3KnHxmgfpg27qYuOmBxo
	OOa7zyswxeUZE+I12hssbqfgHajbiqVhal/ueXQ+70V//PrUYKzWvKAjS1VQnscO
	0H+t/5izpRpn2PcckM/Qw6LA/kZ3MdfpbQWaDpMGTWT3K+OhA3Ro6QvbSDnqM20R
	IfUiG29/CqFdSr/5ZunEkOcsHS7zt5FpIzrwsd+X4pBoQ/Mfi1/7smS6NSgFoyVS
	wxpfcDn4L/q92cyRkTeyQhjX78n1ioegvCiJ7tbfw3ey907cu/aFI7RPfQib86kB
	aAUtXw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt30n0kw8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 27 Apr 2026 09:16:11 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50d6bf346adso126744741cf.1
        for <dmaengine@vger.kernel.org>; Mon, 27 Apr 2026 02:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777281370; x=1777886170; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f+eJOMoesWuzpXTSR4Li0Qt2PYtZi1rSvrjFdAlx9Tk=;
        b=fzpaYRHdhMspOmjmgmeoaRrLajWIKqwtOsWKXHgVdBG3xY5Gc6idlrsILiNiR6h0nF
         R2PT3d3UavovCmRmZh6x+jB+elKsxJRQIxxBu1lxyyDWo8BcTTJsHGFvS6qgZAWDW6lo
         B/ndpIC2X+e1R7k9+5MJzE8mAFN1MHO4ykI8ISeYIgKYWLR+vQylGMN3Wy0wAA3PoDEJ
         VsbwSDrYO3zFnpov0Q72pt7vLPHjnAAu/B1JKiQC+DX6wc8BqDaxht0i9fRxithQ0+41
         9XWefSEB1ok+Y2leFejrySh3Efn2gAqq3FDafS203YuRMEx7eoRGMDVHTBwJZLOV4bxu
         QhjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777281370; x=1777886170;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f+eJOMoesWuzpXTSR4Li0Qt2PYtZi1rSvrjFdAlx9Tk=;
        b=dYDW2A8ETvbC38rKIe49frs33AAxoAp7Laq8Ho852O/g06iZelJ151WpxTER6LOYgD
         wk97y7kl7g82VTDjo6+lnR7NAJyGGA5dn7sLsAFDykhIqyKAGui7C5KQMtdBs6w2QWHy
         XaiTa6jdvrMSXJB+75hbvSCoGxXobjBufRu6pm+ZmFIHuSAtsmusGCS30o/0QKq+sDFi
         +So7xtkU8GK/PcGTEqMnpamiVYQBg+GWjePkB7CoBC/393mBdpP7GNpHXr/JI8dh2S5M
         sBhVIrePQQ2oviAbYkuK+rQ1Ljlx9+actDCSqnssHRV3dHZxH3sd7X/oUjVEiaN2JMX+
         W8jQ==
X-Gm-Message-State: AOJu0Yype5z0Ap09NQxQvvYffU+HaXooqB5e4n+CQc9Y/uKhXk4Qkss6
	bFs/ZKyO9gnZ6pp2sW7oZRnxRSN57GW6jI+rsZyzUe9SShhGn88SXMJ3BDSBpxfoIEmh6qVGDmn
	auPbJzsWMo6AKkQnkptMfDiB/K41BPZ02mlVWdhXlGq0KtmnPSiKHuDX1AYtS3Q0=
X-Gm-Gg: AeBDiesX2/Or7TwHxyc4/uQvjJO6Xgj95yoBRStP8qCXoX6mMhbwGV0OVL0al9xeNor
	qvcvvd6Q/oUnbH1GhPbzEg1fUuzwFJ8rcifKRyUIGSEa48VveFaGWDSgyq+j4YdhRvfrzYsq7Wc
	Aofjf4YxFA1AZVMcR6rCEg5kYE1W0o9vGz4q3kwzFo94KOUE/8/qnsFJYuAETgqdutkUdsbc7fe
	DYZMmiB73opcWxaqDs05PMg9c9HBigL1d2UFeduqPYv6AtwnhOqe9Ru7SXV5H+9RRwtwYUECevb
	J/ASaISibXzglf3QNlcMZ1rAnmYCNeBajZNKNe+6S2zT0BRQHCo47fI3uCuK4IRp4p+OSVjdbcW
	lTkJXT1TNyatCtp5bdqqckNLpp9m8DbL6Q3YlVzSGqoyYGR2LxDLM+Gzz6JZdYQ==
X-Received: by 2002:a05:622a:3d4:b0:50d:9174:cf33 with SMTP id d75a77b69052e-50e36bd1596mr641063791cf.16.1777281370243;
        Mon, 27 Apr 2026 02:16:10 -0700 (PDT)
X-Received: by 2002:a05:622a:3d4:b0:50d:9174:cf33 with SMTP id d75a77b69052e-50e36bd1596mr641063091cf.16.1777281369336;
        Mon, 27 Apr 2026 02:16:09 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:5062:ae86:23aa:702c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a6dbfd4b5sm40559365e9.28.2026.04.27.02.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 02:16:07 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 11:15:39 +0200
Subject: [PATCH v16 06/12] crypto: qce - Include algapi.h in the core.h
 header
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-qcom-qce-cmd-descr-v16-6-945fd1cafbbc@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1260;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=SMWOwwGJxSzHnqJ7yBoaojvGxwV6GTuJEaiwl2WXaqU=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBp7ylCsbY62JQL78TQ6pa7tPcwWzVMzgWmfI8mt
 neuwrXBYoyJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCae8pQgAKCRAFnS7L/zaE
 w8GeD/0f0hGSRTrxbft+ky11wNOHW6gpPsQUMZxchB0jlKZ06wEuqPjrZmdzeq+eFBN9PavylCt
 2MNzx7fi40kYNwqJ3ZU7eF808EBXT1WsdhK+plZ4zsg0u6zYoa2WqRQ/KZx6ED+iV5qDs79L+/j
 Mv+BBesfRJAMPzZhSWCx9FPsdPoaxXa3C2jchI5FFLjnS9paJsdyyZAEV2F9mrQAmZqw+gGaSx2
 iHgY8CAfTIkOzIKhxx1TMDvnk6B16lf1z8tc2T8xRZj+96st4cD0rbunTmtnh26mjKkAKEuDHXG
 zqryNCPVQesibGbyDEsCNgPatTUxvF70H8FF410ZTbApyNigXMvMfPkrPwrvvh2rWCCjk8ZcR23
 HuOz/8sExodRlzZli0bLZvKZ0GHLJdcHKKqvYsUchm233e1Y/xauvgTduCdrpGGiQf3foEm99wA
 +y6BteSGDADA65/leQTZO0/Z5m2v1x5XLLo+4yIGiZc7nftUdAVxK4+ZT4KudGm4MMl5MjQ/+0m
 kvqsMyoIJBlHhHwN0eL1ODj9pQT8g5CJzM+F7SYWGhXV5nP4KxRp/U/qJ8jy2lWy5vN760hSLhR
 QwWaoZc3l/2FNDTuAjNeMf5SftLEj7NZYJpaH/DtfWmtARmll7laFLAwj3bmLoMqDbx1JGtnB30
 Y4KS4Mro9F37KwQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDA5OCBTYWx0ZWRfXwsAie9+ws/To
 ToKNAK2IcjFuzgE0+2OrJccAkzjwIOm1OxstEmgRfevRfsPAnhIMyMDOa5tZYiPz8G30HkWYOx1
 g+x1OCydI5A5M5mRFMvXQRz9pklyWIfMmR4IoTJBitfs+P64+5SBh20IUZGttfIvqjjqYoKX92G
 7X3VmlyCvf49d26TC+8/+YdRksGKMWdgv8JukRXsastS6K4XInTuoadphZ7KWtK5D70wI40Fcyg
 6EZ2H74BcrFBD72f5eh/ZHmkoDy+IRBIeMde4QhXCV1z5oQhHf3/1GdkxSVql/b0/BXTgdCBrJW
 xjnNmfk40moul5u/ZqQUtk61HlXEMjC0hmwFjfKz3ARqIHrK0B+y4+aQ2vW9zP70HHJttDOjzkI
 h/Dv1bXoSHP4Cr89QXnsXnO7RwtgYMVF5Nw+GoTPkhsgaP3geQGAdH7NZk8gNysCs24wr8w42ui
 7SsfXWvjYzMB4GWv/aA==
X-Proofpoint-GUID: MmmZcqTn-HPMp1-sxOdebOEHVcqodkOg
X-Authority-Analysis: v=2.4 cv=efANubEH c=1 sm=1 tr=0 ts=69ef295b cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=rvG61WhHFVBzVmnuldcA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: MmmZcqTn-HPMp1-sxOdebOEHVcqodkOg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270098
X-Rspamd-Queue-Id: C2E7646FB56
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10130-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linaro.org:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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

The header defines a struct embedding struct crypto_queue whose size
needs to be known and which is defined in crypto/algapi.h. Move the
inclusion from core.c to core.h.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/core.c | 1 -
 drivers/crypto/qce/core.h | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index b966f3365b7de8d2a8f6707397a34aa4facdc4ac..65205100c3df961ffaa4b7bc9e217e8d3e08ed57 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -13,7 +13,6 @@
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
-#include <crypto/algapi.h>
 #include <crypto/internal/hash.h>
 
 #include "core.h"
diff --git a/drivers/crypto/qce/core.h b/drivers/crypto/qce/core.h
index eb6fa7a8b64a81daf9ad5304a3ae4e5e597a70b8..f092ce2d3b04a936a37805c20ac5ba78d8fdd2df 100644
--- a/drivers/crypto/qce/core.h
+++ b/drivers/crypto/qce/core.h
@@ -8,6 +8,7 @@
 
 #include <linux/mutex.h>
 #include <linux/workqueue.h>
+#include <crypto/algapi.h>
 
 #include "dma.h"
 

-- 
2.47.3


