Return-Path: <dmaengine+bounces-9367-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBk1BTlEsGmshgIAu9opvQ
	(envelope-from <dmaengine+bounces-9367-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 10 Mar 2026 17:18:01 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D8C2548AB
	for <lists+dmaengine@lfdr.de>; Tue, 10 Mar 2026 17:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 26B1831B26D4
	for <lists+dmaengine@lfdr.de>; Tue, 10 Mar 2026 15:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBFC3A543B;
	Tue, 10 Mar 2026 15:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AiiIpaWq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HjRBsOvf"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4413A6B85
	for <dmaengine@vger.kernel.org>; Tue, 10 Mar 2026 15:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773157500; cv=none; b=CSSd+aMCKx931gv0k/TDFPASHdtD7jaMJ6462WPGOTWgWpJoUxBjzcex7o9Wk0rC6yKvQvfnwyZCpYarJ/7zKvB1LgNZ4QrHXL0WtH6F5OnPB918SvbcOC+5OEDV+p2NygEKBWcjXG0EhE2Gp/EjEhtFOppDVOJZnrfq6Ga0g50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773157500; c=relaxed/simple;
	bh=D/DbbvsYNV6WfJJN+Y3qtsfzsdueJP3Q7cdgK44aCk4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o6VP/P7GztKq416YFPTEmilnBR+uvBh7qIt3bfrlv8bvs+105KmiDVUgadxViXxQjpXYYvz2Cq/OyblsLzzyVfbsNVAJmNTobQrXvHJ/q9KPU11R0nRrYLI2TvJocpPI49U9Ihpg5okMvY60r4ZYweF/7BjmDtwx5K2Abvxdkgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AiiIpaWq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HjRBsOvf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62ACaX2t789277
	for <dmaengine@vger.kernel.org>; Tue, 10 Mar 2026 15:44:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f+eJOMoesWuzpXTSR4Li0Qt2PYtZi1rSvrjFdAlx9Tk=; b=AiiIpaWqXpKki8Pc
	E3kqxUeNlVehTwfUf6LJcxsxWMB7siFCCcIG5f4I9yV3d5ZQnhcUJkjWnQ6ug+yZ
	tz7kdDeW4FHe4xEvYwhZwlKkolXvkubh6ia37LjVcq4zQnrp7kXI+hdI2gRdUZBb
	OLUU13nTGJYXelzoKii2PhLCul5m2sKecjvt/+iqiOmKiK24h51zOLg2ZdNeprln
	E3xzMxw6YD5zYk4qWmz4ex0JToc6tYTA0bN7qlOZugdMCWk2R2jZZP6Zxz3wEqUR
	h0SdDk022Cy+6H95diIM+F74vieQIb8Ne3a/o/ao1yskWfElX0qCHj81OHxQlS04
	e6d/ww==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ct1ekvkng-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 10 Mar 2026 15:44:58 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cd77bc8186so3321824185a.0
        for <dmaengine@vger.kernel.org>; Tue, 10 Mar 2026 08:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773157497; x=1773762297; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f+eJOMoesWuzpXTSR4Li0Qt2PYtZi1rSvrjFdAlx9Tk=;
        b=HjRBsOvfx0HIzDwkEvIia1S4NAIdAlW6a+0D1CHkPq7AyoVMWDNLkgRUVqTRUw2l6Z
         msklg09bqfIh2OfEzZfSYLx2TDldHdHcCYuSBnwrylA6c1Cne8gMv4+/pVnveomaYlEa
         Wo4GLYTvmGeZA03+BXw/bDzyQMkQc7fREO+RdjWzykmBFHl/dmsOtavL+uGAardFadbM
         La6T90YCiA+WC5AIB0c1HksbYa4Ijt49fEeWOCeIpSSrpwk3uhI97t0XkWNX6Iox8F2x
         z6/dVaopvpfypGClGzx0qmGMDBmwHgnOZA2TclKcYB7tWl1C6bv8fwxrHO022newbt38
         TTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773157497; x=1773762297;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f+eJOMoesWuzpXTSR4Li0Qt2PYtZi1rSvrjFdAlx9Tk=;
        b=DGGo+1AYbtLXi7tLOA/zcsFGXO/Yj5MzADiG+nFHFoizRDbTIwDSBBj0B/jAOXDXE8
         aCYPBSmO++e4LRHZixRzjI6UZkA7AKlNCVbVjC92+SAPQsJtwYA0aF7Ij5flZe4z3voe
         WEOHQwC/mQtUzaGP/iMrgVTvxyIKB4t/5Qi2CRHryCqCVOYq5UdhtZjl8VmOxtQ5QpS1
         PYn2SA41OBvu/FGwbndpQ8/awa3kHEssuoJicMtzsZNHJ7dioSAuThpQaegU+kD0KJ1p
         wW8sMWNGWNDQR3iHc2j0yfFJbtvcE+opEbugxR4VytGJm09staoiBPF97hJCOwcFlwuB
         q1Fw==
X-Gm-Message-State: AOJu0Yy1pSsLO/s7fgeNiKn7jqHau/CVXV5b7m2U/RJGfcu10yXVPVKG
	l4GfOGY1jTLfgRCgKC2x7N1n/ykuilkv5YmMaQ9GXQcVdmVC7XP+QEK/7LIoHMDP6N2DH6vtr/o
	Xvu+iMBX7BBVOSLjjCBgsPRMOT+oYiKltX+sGTjRCpPaRxq3JPqeXMJaB8+yRbV4=
X-Gm-Gg: ATEYQzxLFihQcoGQk2cWiuk+0BW40/RCQhoGadb+W5zd/0ZCqPx+6Cj4JrTZylB+lnk
	lhs9h21mGSpzUF4Z1IVX7MJIvO1qREY8LvzouFdyhKTOgOe/fTjle1ld/WXuAfBXSHTEny+6ZE5
	wuKqa+9beAQPvkZ869SEMTwx87EEWwp+rh2RmShB9DdVTjPUl796zsemH4AmlVH9rCFkiXhYXto
	1wYGg5ezBwfR4zfVBrn4R//u2v5lURLNEdAsF0QeKdku6KR6DJOyF1fi66p+rPXWP2VC9pk4U0W
	kxyWPJ2DM5aDXNy6vo76c5a0qpLPEp3TuzKOKk5rfNNsOUaKxaR6Bm4bm0OTq61SmroL4K92o3y
	UZ55rCqg+Alnd6v4IZDbZzTgNo6laHbxXFe/kMo1SVn7j08lqd+sK
X-Received: by 2002:a05:620a:459f:b0:8cd:9231:8b54 with SMTP id af79cd13be357-8cd923194c3mr566019185a.62.1773157497156;
        Tue, 10 Mar 2026 08:44:57 -0700 (PDT)
X-Received: by 2002:a05:620a:459f:b0:8cd:9231:8b54 with SMTP id af79cd13be357-8cd923194c3mr566014485a.62.1773157496748;
        Tue, 10 Mar 2026 08:44:56 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:47e6:5a62:7ef7:9a28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8d968sm35991600f8f.6.2026.03.10.08.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 08:44:56 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 10 Mar 2026 16:44:20 +0100
Subject: [PATCH v12 06/12] crypto: qce - Include algapi.h in the core.h
 header
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-qcom-qce-cmd-descr-v12-6-398f37f26ef0@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1260;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=SMWOwwGJxSzHnqJ7yBoaojvGxwV6GTuJEaiwl2WXaqU=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpsDxlQlPRGUaNldGUW96+bRTO91zN0L2uk+4lc
 p7wTjvcvw+JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCabA8ZQAKCRAFnS7L/zaE
 w1apD/908hNmtgNlCAkn+L4FvAUewZLgyKgr7/esEj6bAVtRnLpfcUCo0hBzMtaE/Hth0b7A0UR
 KA0Dw+RN2+eykOGbwnPDt05CrE8OvQoBuIb1i/eKE4U/IE/rFfrVPL8IRfThjmL5W9AeTe2Vz5n
 hINZasNUEJ+aq3aK52cswdgiA91NE/MJ/WrnnblFg20UAfGGA0d+fmSp387KVqDJzvzzHD9VERo
 NA6x/wmIGLTwTMU7X7sIUutSdcEg8CTS8fLIjY1Ulrt+XrTyl3/qUy4EWskQsicRt8hianEOzAn
 kyj6bjzdwtB44d+O0dhAZZh2qr5YuvVe9FN1Y9P3H5lENTsmMgs+nxoo3JBXZ7kKI5B1iF08HO7
 He80y17YYXV1Srm1WzCqhuD8AbVEjMyNPf/WtgHsryifrn6VAYtr+9wA0d/Zw/Hzmq0C98TNYbe
 qSprE3oj6noh1N0bocANjUNppSpEXTaFb9qGrB54FKQs3nLDFDRtrNB9Z7fg+SAgRCk88MVk271
 Ki2vA3S2jAM1lczzFC41+dR0afoCuhJiEF4oHHshQ3TRNR5CxTscGnHY3kuJUY28wv4Bs/GZ7cx
 La3R9NQJXxH6NQSFPm/MuuiMjerNZTFcDyUZggHmcRoq0O4h4ppoeR/noHkz99DeI+fXIrTPhpS
 Viyzyo4xyU5GOug==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: jOhozrqXwZ8mpdrbg7citAi8old6aG6d
X-Proofpoint-ORIG-GUID: jOhozrqXwZ8mpdrbg7citAi8old6aG6d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDEzNyBTYWx0ZWRfX6ZTgJfVCeggy
 zynSp2/uzlczdCkdt8wxt05h6zLgqRj8rsssLOz6ZYfUaWHoJXFUGfNCUOA8gex7+uecL9QymHs
 rkW893Qr6/l1G53WNswX8QIKcH7zKamcW9gtCdf0VQbbtlR808lFUZsgnHTZB2F99A0Dw6ptDPY
 84U2gQXo9Gjx/jVCAi1O0j3r4fM2VhP6Q5RDqtgJ0eJ6X+L0Z1bIVpY5eCNR16YXWvC1AXA+26U
 hEZMa8gxGEYnEfkVid9a62VeLXotr4zklxynt8W8J0cmJGOUnPBZzlPd8rv/hXmDRUSQmCjQ/kj
 BbByC9Gb4r4K0yC6MPrWIq8cMGylT+wy/+IUTQILXEdUINDVWDPLqaQtR3wXuoljk6SN1hC2ddp
 R6YByKpZ74QZXZelw90zPY8kzBFs74o1wXKhpQCCrthO7/ZcmZiki3IR49hwNurVYzrpugSPgl8
 dtznT9+6UBhgsRJpKwQ==
X-Authority-Analysis: v=2.4 cv=eIEeTXp1 c=1 sm=1 tr=0 ts=69b03c7a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=rvG61WhHFVBzVmnuldcA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_03,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100137
X-Rspamd-Queue-Id: 99D8C2548AB
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
	TAGGED_FROM(0.00)[bounces-9367-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email,linaro.org:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,amd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
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
X-Rspamd-Action: no action

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


