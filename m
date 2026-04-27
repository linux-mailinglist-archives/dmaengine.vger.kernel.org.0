Return-Path: <dmaengine+bounces-10131-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIwIH/4q72n98gAAu9opvQ
	(envelope-from <dmaengine+bounces-10131-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 11:23:10 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3615646FD4C
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 11:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E382E3060203
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 09:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60E13B3C10;
	Mon, 27 Apr 2026 09:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hAkSHaoW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bn8HnrUf"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449513B3BE9
	for <dmaengine@vger.kernel.org>; Mon, 27 Apr 2026 09:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777281375; cv=none; b=kCUxZhbQrjI81x73WKhAVC8C2bBg7SdKn1uNFuXOs3Pz+/6qaEkOifQRnPVRhC71kg1Mwsew4WBvnQrHIq4dgqCx1CbJJtJqinTkSddwBrnmb/LxaNq2RQbdjqglXUS5bUD89Fotun8T2s9MPzd25uxZz5Myi8CxgP+PEUn/ZAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777281375; c=relaxed/simple;
	bh=6dN4XjHr+6OQnOzxmGwMll0VZH7PW0q5aNlxk1E5+Hg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=edyYx+F0vIBu/n/IAkz7P+t1m1OMBUwAxqGMBz1ZJhv9awLtdYEbXz0vA+0htsSu7V09dupcmdfP81AvDKXBJykG06oOh5p8zO/zgjIyuFRHuDzYMYwFKNMUhmINUCzuHAqHkBdtW7rV4cgnJNAy3qjguJY3IKUg6omocYkvqRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hAkSHaoW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bn8HnrUf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R8kOTe3962048
	for <dmaengine@vger.kernel.org>; Mon, 27 Apr 2026 09:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9iGVNuTYeeAltbq14HNN1Bd2g5XTMHQ/MFj6N7hyZ8I=; b=hAkSHaoWWrtG42B4
	qbWi7IhY0L/EJi+aJJQEhBlOmJpuYrEFq2v7UgspCa3rKn2rRauf14RwP3HcXLgJ
	LPCWa7OSz9e3v93JswbXQYuPjyYsJujlCisQkfr05tByS+GwfD84idOzopF8Ygtg
	zA5euIYM5qEu0zEwAsr1h+NaBECldmfRF5+8b4fwkU5kPY98uy0eTUoO6urNBoM5
	YH3npYr8JdLdvDPKoSpPIAeLw9pYcJfBRLABnfEx0q1KoEHkhataUNr8n0oYf9V+
	Tvd7T4taaVDq31bKv80OXvXf7AM/2DTc4TYGjG1wWcEahQhly0+u/w/HyJYm97oC
	L3Mflg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt4k309ne-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 27 Apr 2026 09:16:13 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50e5a336b44so127244391cf.0
        for <dmaengine@vger.kernel.org>; Mon, 27 Apr 2026 02:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777281372; x=1777886172; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9iGVNuTYeeAltbq14HNN1Bd2g5XTMHQ/MFj6N7hyZ8I=;
        b=bn8HnrUf+aoyoQ2GgMx2a14WW3AjQt3jpYcrs/gySEfgl9wovCgXnEb3hWUhIZp1Dv
         5qtwo2sRkjRocir4Ucu5ioELUek62aBNAC/9bnEtcEa9WSqa13+Ndj4UdDhhq3vg8Pbu
         hdMASHM9BrV5FUKi5mw5e6m8Kfqd594kDv+qLLxr8CMbeAyel2rVM/jCFHtXPVxWig5u
         nuiAFvKuPKmFkwihCtmwYPkCJN8FR8aAebTlUA4VO1oUXctiuWLgrAQEUSvXcKRZvxJr
         XLqbLRhtSycEFk47zIqB2IEX6mFJn6LJUbWy5fUlqbxhirJHFfv0ZLk0aAYRY0lqtOLr
         i8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777281372; x=1777886172;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9iGVNuTYeeAltbq14HNN1Bd2g5XTMHQ/MFj6N7hyZ8I=;
        b=frJbBgRs0dnzYlWJmR9XbQxUh+OMF76tt7pu6lbzBEX6aNfqJ+zMeouASLW/iJb6aM
         OQ8BmTB1teasKUEWOBjH/LufDcni1eP6hwNgrLn2NjnyK3T4SDBhEZZfsYTxc5z94oFg
         wweBs5/PXKExloT79SARYn61scTKY6SqsF96FRWsaCuJhAI95Eu1kH2qhYghhHOZKuHn
         C6DUnkmCa80aRA36WnEtBI3zeCjIA5qjTa+rZrSH3vjVnCmOeHv5mudHkt4pz9HbVzFp
         cJrhZbtuIeVsGSsdf7B5GQVlsHpAodjU7IZvevCfOQopAMqtTL8PzRYzkp63xYQ6flJa
         ODTg==
X-Gm-Message-State: AOJu0YwDeHL8o5gNwE2hxy/ph+BrNhI9tzxjqUHAtjO5JQbQaR0udtor
	WquGj4y94ZYLNzvEfZzQ8ylc6Vk70SvgvWLqizg0erilT7tTuRXkXDVpSbQUSpPbVXuI8tH8QtW
	Eo7LULE3VgZUYPKqyzhi/3fKukbcESLAkqhWrviE8cadl5iA8xAn0HCI5/ix8GcQ=
X-Gm-Gg: AeBDietzTH5XrOMd+YCvc9oj5NWWr7rwfJ/a/4l1RndPZXFVqODIV7Oc8my1SoR3Vvo
	HRU4KqzfBMvnPBMg4pLkaMONZJb6G9jQFQBi3Y6aL0/GD6pFnbxfHS0sFu8Uh2cjQaFLAiJdDSI
	Nr5TZ8Lqbr34k7V/QyQ2dQEZfbht2gw3XJPDmEX7uQNmEFuWnQWQYvhzycHZNjsEXbCrumhDWT9
	HY1B7oPZPE5Lp4g/SF0LIzJj928i29plCtQ3viZFQd5UPAs2Z2qIVs7JR8jH2/K7tXuHfFCRNEV
	5aAupgZ8xmqP9EUHxbEZpQN+nm/aiOUjzFVSPYD+T5/9pRFa4DNbwn2kUQY02cEFRdBIc88kA+V
	lcKqLqkVYBLhSRrWI6hW+v4TjCWqNei16rjjym1CRqCKtGb/zyTUTw0nLVEdzaA==
X-Received: by 2002:a05:622a:d14:b0:509:5c6f:c0e with SMTP id d75a77b69052e-50e367b52c5mr443363261cf.37.1777281372473;
        Mon, 27 Apr 2026 02:16:12 -0700 (PDT)
X-Received: by 2002:a05:622a:d14:b0:509:5c6f:c0e with SMTP id d75a77b69052e-50e367b52c5mr443363031cf.37.1777281372055;
        Mon, 27 Apr 2026 02:16:12 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:5062:ae86:23aa:702c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a6dbfd4b5sm40559365e9.28.2026.04.27.02.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 02:16:10 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 11:15:40 +0200
Subject: [PATCH v16 07/12] crypto: qce - Remove unused ignore_buf
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-qcom-qce-cmd-descr-v16-7-945fd1cafbbc@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2012;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=DfH5Bb+Cx5AadRW9+jaH1GcMtyO0VLpMWlVREcJBr7o=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBp7ylD7u2M2axLouF1vpw9+ltR0S7tpnfX/9Xf+
 +0QcBWiRtaJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCae8pQwAKCRAFnS7L/zaE
 w6g+D/0SY9i0K2JU5To3f1gUmDIN2vAiSXf7FHzH5Su/kfdOHiflT8xHNWcRk3kh6l2yplYk1In
 vVrQGhhM5rJNpQlEr0XXq24SW2v18VB0vYp7UGe7tV2fPFon4FQsE5eLGXmbIi5TeeyqilnIAiH
 AaetOOeZW/jQsnwNlLXmBQRD9dNgzi5k+u98QO/ZOes9obW+wYfH7NrIfyBrl0lhE3fbyefQsOZ
 DJg3QteyKYLgaJsFkaLP31wXLtY9j7iX8cwMxHvnY006k4qCo2PP4WCgE1iM2hejLkEpKC0WYuA
 xqhJyI11uFCjoMSyXeO7LtEGMHUHbv11DVVUMsPYelwVBtmwYvjjVAd5t2UgYIS/Ijaujxu0qCq
 MXB8cRR452xACMNZerlKkuvPB7GYj9pZyEj6Nzo84M1Xa6gf94VhNofXnY/eZN0tCmn4WZD6F63
 L0m3B3iQjlxP0cDNuV5CDeDWifbfqHjLIxw5uopNiQ2omBw6WILc988JbPiRNHgRXSmmDSgcMMo
 Xt984kq8d+EBEJLg5oR8YiVIor19i95HmO+ROhLJ6YuiAbj05DaZpscSLZdYUk5xcT4FcPATm9m
 wtf7IV8Zkxnl9XEVd95t+yGterS6ZiW7rpW9FGPnsg1QWzZVFfK3PB6DOCz0pJqMZgRXoM0TgoN
 1i+6K0sCgxTH/zg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDA5OCBTYWx0ZWRfX+dtUZBbNtxku
 vlx47b72lV0On88OuYTIi/7z18UEHS2Bm3iturO/OY3UfelSq97W1ma1QVWWCF3+8jujK1YTFdg
 2LaEioVEE4sDvjl3OAqD42oEklBiPnClKyJxYZSdefKq5x6CWa2aK7rpsgz7nwwoC5kaWywxOib
 DOb0AOC5Uo4l9pqWBVKr7TzO8A6y/BLd8iwrKH8h0lDVhIEwLmo9Y5sZDv/xZqyNkJRjcBviigw
 T8mtR0naw37epW65HPCauG9krNkY8GZhoEz3u8SQ4RhG20zEDKpI6qqhQoCsYfFbKC8TuwedHiR
 NbJoAjwNm+EOBpd7sAgFUrC+70PDa0LNgNtsp2J2AQfynpNIQg8OWRb9s8UQyLNLZWrDb+ADNRv
 ImVrL9zgfs6BsXQrOEdvNrxxMQNR741vb2VdFIgFBMUZ1jf7nYr08XzTWYOIinZOrVAd/9F6Qo+
 auUWAZJWKksQUoykG3g==
X-Authority-Analysis: v=2.4 cv=a7QAM0SF c=1 sm=1 tr=0 ts=69ef295d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=tWRRbWwrKX-5tUpmLDIA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: t_xYsP2eaqMxmTg-zvykrR6VuRyQcpZN
X-Proofpoint-ORIG-GUID: t_xYsP2eaqMxmTg-zvykrR6VuRyQcpZN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270098
X-Rspamd-Queue-Id: 3615646FD4C
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
	TAGGED_FROM(0.00)[bounces-10131-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
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


