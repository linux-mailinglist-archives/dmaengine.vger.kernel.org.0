Return-Path: <dmaengine+bounces-9369-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Lt6LD1IsGnFhgIAu9opvQ
	(envelope-from <dmaengine+bounces-9369-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 10 Mar 2026 17:35:09 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C3735254E32
	for <lists+dmaengine@lfdr.de>; Tue, 10 Mar 2026 17:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 014AE3203F6A
	for <lists+dmaengine@lfdr.de>; Tue, 10 Mar 2026 15:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492B03A16A7;
	Tue, 10 Mar 2026 15:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P1/Grsya";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cT0iw+u3"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3713A6B9D
	for <dmaengine@vger.kernel.org>; Tue, 10 Mar 2026 15:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773157502; cv=none; b=d2UmxwyyNNlmshwlwDTRJ/3aRdjpky7l5K7QXgikVyHNrQN7yFyLBWZ0Jxe1S89mkf6Kchn9jV9EiPp1Pjn5Oh/R/qusmq6eFTC9jgv+PKKVqLefqyDgtCZmmn0gcSVbfgvA+GndV5Ut1uxr6q8xsbbprOs8yLqKrFrWPP3cbxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773157502; c=relaxed/simple;
	bh=6dN4XjHr+6OQnOzxmGwMll0VZH7PW0q5aNlxk1E5+Hg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jR56NVefWNWqFYlUYwQysmC7jASMC3CUnjh9+jZ9ULGS63Lpi7flC6S7t4qq7wGOOajGT0f4JT5nojOHbN0lhmt9lkbnbvsOPmGf3EipdRFLUQeywggbx95Mkh+r2BpRwtxgQSAsmeHFDfPLms4PhO3DJg57bfmnD0xDPElPOMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P1/Grsya; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cT0iw+u3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62ACaVR81502945
	for <dmaengine@vger.kernel.org>; Tue, 10 Mar 2026 15:44:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9iGVNuTYeeAltbq14HNN1Bd2g5XTMHQ/MFj6N7hyZ8I=; b=P1/GrsyaIA2oSetH
	qyeav9DFW2XVlmvlGqPfQIv+eWCC43lgxBPSd/gqGr69BOQvm0QgM9MipdPFDVq6
	I18t0iy80eSWl7F7kIW8CK9lW0zZRh1+6QbkViBqou7V6BVLBCV8qp3VzBhKB0Ud
	j+Q+qDDbWmNKq8mukpI7x9BCcx8J4gR3n+3O4nAG9ciRywZUW7FkdjzyV3qpLirG
	lyM9VHhcjH86rOV2TgyNVymX95CiMXng6JiMG4EgDTa0d3qp2L9c/4QFndzIyV1Z
	b890QdBIgn8Z0WCvXfCh0lnF3XyQ6T0dGELQFR6N4pkTfikGYDxEaC3RmLOgSAx9
	0lDLNw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctdf8j7p1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 10 Mar 2026 15:44:59 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cd781c0d90so1653567085a.1
        for <dmaengine@vger.kernel.org>; Tue, 10 Mar 2026 08:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773157499; x=1773762299; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9iGVNuTYeeAltbq14HNN1Bd2g5XTMHQ/MFj6N7hyZ8I=;
        b=cT0iw+u3d25XErAChj7lkf4Gpfqhj85Fbx5fu15VzBhfKpDQJ472BV/nEnpkH4UqY8
         CC6XF/s0r1hhs5W1dJ/FyLXwnovaqsnADpYYjZyb4j3NKf2vMN5X8XkA/goyF8gHRs53
         Lohauk1A4U9ggXlL2XzRDbGwNf1VBmlfqG+c8kSlEiOo+28IaUlANKkOhsxfo3yaaxjE
         wAXzwyFrHw26l9Yme5VYC2twcJ/1z611KwBleODeS6HRl2gOFWj7X9qWclpVgnyh/Lq8
         INvKXPsctonXzKSGkXcETpFAXR/8ZCNoSZwVYypHfAcvxRHhgy3Ygt+f1np9kxH25odS
         Y7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773157499; x=1773762299;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9iGVNuTYeeAltbq14HNN1Bd2g5XTMHQ/MFj6N7hyZ8I=;
        b=CfUfTORYEDcNZ70Kw0KnmPXxNkuLXTIHJEt01v2SGlAP24Vsgq7kgP3cOGVxZnpGRM
         MFnN4CuZVOCKmL5gpf8ss29SLQkInIrIo0ah1VmKwP7oQQUHE5WPSIjcEgl80Y1DOIg/
         FXzS6eXJoZl64QIOwlFlTrIU8mt2WFKenyP4vvxKX2MWGdqWEEPGMOZGF9gnawxmRp3E
         WhoB21WIMiSgt0Zv5Wcd3t4a6CL19QN78w6msTgn0JEiBxRoU5JASfw2Vly63BItBeEs
         fj1d1sU1t75mEJ+LWVyItstlAQ3nKkmaFduUsavtNSDuF2tU7Fg2oYViVIevZX8wcfOl
         D2Wg==
X-Gm-Message-State: AOJu0Yy3WYfim/uCgLaWk0wRpkT+5iPTLlsa1Ez77dxQ8Id4pY6lRV8V
	7de/KCIgUPXHtdjxZ4S7DJmXWFP0RIm40X10FpBm7iaNCHVo+g6yhtR/5N3Sa/GJo8D1IkEsk8M
	JhneF/3mvsYWUIvqa1wrBMI0PDlvNh6B5Cmuaq4l6DUE7aQ8AdtuO/6UV1FDPO+A=
X-Gm-Gg: ATEYQzyuQkeV/BWncyfNvH4jNwDyLJ+DjnUGNtVh5VQgEDJvYglNcTWZxCTzQfCDA9H
	cyY6t6zEmRltpEnZBFvkR4CjZDI04Q9s6DzDLhnKypsRylCqYJyErrkhh30XJ3zuEDiFjRa3m4O
	jdyA/Lso0M1BBQU3l/6waYKQ3hoC6TKdAoZgl5jb/96x86FFM/NjuYeipXUj3hf8r1RkhH8at9t
	/O73AFinLw6cvDuxiHS8bgr9FbOOb+Ttpj9sPTVbfK1NpMkkc6qzH13Qu7gzaJsw7XT+G+FuvlN
	jwVTuROOUxJT+04dAzaEKDqNTChKV1p2lMKeS/XMG5EaUbOxfdLns2uM1Ku9rjIYEuQkkyJV6xn
	pPr6xikHNeYQ1HBcIU4MBKiIcghlS6w4fVv7qZqZmhmkPIHTnIjWV
X-Received: by 2002:a05:620a:4142:b0:8cd:87f2:1cf with SMTP id af79cd13be357-8cd93becd02mr444893385a.20.1773157499065;
        Tue, 10 Mar 2026 08:44:59 -0700 (PDT)
X-Received: by 2002:a05:620a:4142:b0:8cd:87f2:1cf with SMTP id af79cd13be357-8cd93becd02mr444889585a.20.1773157498559;
        Tue, 10 Mar 2026 08:44:58 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:47e6:5a62:7ef7:9a28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8d968sm35991600f8f.6.2026.03.10.08.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 08:44:57 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 10 Mar 2026 16:44:21 +0100
Subject: [PATCH v12 07/12] crypto: qce - Remove unused ignore_buf
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-qcom-qce-cmd-descr-v12-7-398f37f26ef0@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2012;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=DfH5Bb+Cx5AadRW9+jaH1GcMtyO0VLpMWlVREcJBr7o=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpsDxm7NNbkl7dnR5eoGZNBh/IFZgrDD/Cz7G1i
 Nuf0N+OiJ+JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCabA8ZgAKCRAFnS7L/zaE
 w8NNEACAbBKH2NWwSM1Mz+lOJfH83qaOWjprWgrcCwR5/JGaCQnrFvy63IiH9Cp9njz9bbvb3sX
 KIqKY13S3Lcnsab4bNU5UL1h3uKpBh/++69VsiUGdjNACk8Jp7wz0FigRoaYBqtMkjxeFlo3bRM
 LT6uFjE4NQhW6mCDI6fC7ZxdwayrLrNEGgpFmccQNIj96aOxtJ1Mql631jGWJhqUoVOUoVy/M/P
 lkmCKZyW6xeFME1xZ05QSe+neR/2FTEwdCa6/lv1IHrC5Ufi+Xq6XBtdeAwBraIXrf9TXNNnPBN
 er8sj/RHTaePjHJAAzKRHBrzWxGemSnr+zVRNE4hMhoNYeTvn9LvfoOBUSuGNVpR3CpDJBdkwZW
 nrSzkkfxc1Xe7+xX6ovsPtT3gHyRdiM64YzOrOIkZiAGkfMoBbmPpdD2Te6mqyLLex+rTI9Ww5B
 0LRhSROfBlHDIJ9D6OpJAjBoPOWdhe31wX86PZ+2zYSr6u9brW0pTR6lLt6OYhoBJr7bzql6t6i
 wSiDT9l3m47j/pfJGSDyCITTycql7iBtXEuaz7z2aql9Be09aoGF8ulhlt9kwNyamfQ2d/+g2ML
 305/3e6tCVFrRUIMZTNP5dOm6jw7DUQyB0fFPy24HtpSzBpKO6DRzHXSUOngL5uP3+GwxkVwYKi
 +axkBwuOz5l3ySA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDEzNyBTYWx0ZWRfX75G0a16DpqUk
 klvxNO1TB/0NrXnqQYGntT+TmW48MKGgIJq9Hi9JYg3lGZ2/VnwuTV2/HIlYrdhZcUaB5Ye8hlI
 +ZXuOTekA+b8HSrlQtDAiKP1xAa+FwUrPvqSsGfBpWh0M+1apppOnsZu7My33KeqMw3YR4JKBgP
 Eoa3S5jbi9AsWg5l4vHbryAfKm1x9ASwbpBVUSVfPrBEUSpWvBaVpVxtRwswewmQSomz2bx5pIV
 3VVntkBKspudGYqvTDc3OGj6RhJgG/CHatYTqz+t5F61Y3AHFmEvLBadjo5S5Sn2ZRbuiKQIyK7
 Gj871rUrHzmdO6/45j+Ik7h7dTAADjnpCdg+9kheQCKY7KEXul+YuhkMXOnvpVImfRZiAotjmDL
 2KsPpvqtwFcq9+qVA9h36+wVCZnLCldt2CyWF12wb56iDPoITGXMc8pmp5u00kRLpOiIIbfJNw2
 0SnxMuZ+vIVBAxEUGsA==
X-Proofpoint-ORIG-GUID: FC0F7CIZE_UV5SjrpAajJP-fni2qpD5n
X-Proofpoint-GUID: FC0F7CIZE_UV5SjrpAajJP-fni2qpD5n
X-Authority-Analysis: v=2.4 cv=b+W/I9Gx c=1 sm=1 tr=0 ts=69b03c7b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=tWRRbWwrKX-5tUpmLDIA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_03,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100137
X-Rspamd-Queue-Id: C3735254E32
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9369-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linaro.org:email,qualcomm.com:dkim,qualcomm.com:email];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,amd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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


