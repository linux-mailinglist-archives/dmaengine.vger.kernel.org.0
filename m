Return-Path: <dmaengine+bounces-9606-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCHpOt9gwWmaSgQAu9opvQ
	(envelope-from <dmaengine+bounces-9606-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 16:48:47 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C342F6F4D
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 16:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9515F3134D5E
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 15:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6B83C552E;
	Mon, 23 Mar 2026 15:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QFw4uWev";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i1mr4GLR"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C333C4578
	for <dmaengine@vger.kernel.org>; Mon, 23 Mar 2026 15:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279066; cv=none; b=a7zswELclA+vEdwuwN9K6+hz0Wl4fkd38RQbLKUzu1rtCinVO2MSoq+A5g45m6/KTlXcMiYSwKWhYC6ns6quDBpAr1aIl49m9qM9DmLd+c1s1W2nzt+ONKuM/meDcGTnVLD4TgVy6Bq5i4GJBXoxxAAJbSPnBW1KPpWpMAhy0E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279066; c=relaxed/simple;
	bh=6dN4XjHr+6OQnOzxmGwMll0VZH7PW0q5aNlxk1E5+Hg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DkI/ufUN8EZXlRVdcDpZ1+m0QmFCsBJDNs12YS6nvixlooWmXhoj6coaAfXeQc61OZkaVhg6nuJ06cDpD4iOpnkg+L8lK/1EdvjwFmpx/hNzvHfwAFFYRqQbE8lVGOTOxB62+W21wqYNwbIinEGt7CZyjG3GCv3Q6lbRLQVuCGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QFw4uWev; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i1mr4GLR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NFGS3J020865
	for <dmaengine@vger.kernel.org>; Mon, 23 Mar 2026 15:17:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9iGVNuTYeeAltbq14HNN1Bd2g5XTMHQ/MFj6N7hyZ8I=; b=QFw4uWevKpfY2N6K
	Do92gBz0/Fcztm4sKFqSsB3N/ScI/GDUXnXWkgxtmitcs4oxD61xcq2i/vNb6wpl
	7hhNDKcZyzRGJxZNV/ePerOLoE7v55NNad0eaqZjSEBhcPsT69QzSc/lt5gLALDr
	9/dw7vfkdbHRiJIzokGrljw31lhU6QpaccQ64i24VOU1YK4qtaV5boEJt7uZ7uPo
	kfwRpViFGmC6GzI5/tEiMk/LGpOrf6QViNZ5w9KFc2Pefgisy7xpYnZAyPZXsH3+
	z5o2cvLpZMUpX3jTNaGt99BFwo7AjawvxH/8HMSmPn77/OR3p9dZWA8FqsDeEDwk
	Z9m6gg==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d33k311su-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 23 Mar 2026 15:17:44 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-9484dbd65a7so212747241.1
        for <dmaengine@vger.kernel.org>; Mon, 23 Mar 2026 08:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774279063; x=1774883863; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9iGVNuTYeeAltbq14HNN1Bd2g5XTMHQ/MFj6N7hyZ8I=;
        b=i1mr4GLRrb59RGl94OWlul6KHex2fWRDi/+coykREoxfLiMdzvOqdOr4aVdRVZ6cEw
         OF6xu4qpZQEiXRmEVdsybwF97F8gLF90qYd5DinGt1DDQK65zhpDsMY20oFaz1Ra/PO3
         pTKQ2iZ+E1JRwstyeViH6EZIo5dmC+hV5GlHgeJSTxzdBjdm/de0WBIsxRyxUcf3lLUD
         iGIVmhZEv2/yBQY24KjGefnaH5fVL33Xz+k5mwVYLQCWqBhHk0/7P4Tl78Ndh+QzAbne
         AUA+nU+wIcWZhVN/EhdI2DtUY6iPKmaFQ91cvBQiSNCRh8EeXrvtTMovFJfALmXI8xIf
         JjAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774279063; x=1774883863;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9iGVNuTYeeAltbq14HNN1Bd2g5XTMHQ/MFj6N7hyZ8I=;
        b=ikTQiViG2Gh3irKKpDoalU/8QsWNrrCZsY288mH7IksGNU+gAt+hgxnLTf+iuV2EPc
         zRmfoyc407y9OS4HxQX81KtPJMD6jU0gMlm3UN6wGcm6aiNpVkWzHRg5J92bydUN9c1f
         oKe5eziX8lrB0VoPn84/pvrvE48517QvzYCB7mGrGgyKr7PUw0iZtTvLZFCojx0nGaOz
         H5kH8hbuIVJgt0utLtOWVo0eSfy4GgkoaPsCGk2PtbrRp8SMmZwUuX7aO31jWjGmO/NQ
         stB3wL+ZNjvEOXEwxIjA7RgXL8oCDyu+pVmzYQxio9qI7g8txJqshZC2QB7zEcyiRMtS
         tr0g==
X-Gm-Message-State: AOJu0YyjYIWVyLMwLCzZQTmgUsRIoTyFREete1EzLhvNSZ+3uOcwZfVN
	xnXm3GURZB/j9M/PubD7/R+dH3miEn25fqrU9vEEqP3ga0rPgb+cL/9PwhqrR+DYYecrul49z6o
	apZ0JmgvQqk9H42BcQGs0H1OWJoGryTBLje/V+wk4wppdWk+zvIgPah6gbPj6L8I=
X-Gm-Gg: ATEYQzzLgRjlq95N8m351tuPnCwD3/uWW1mv7HrzJ5mxHOSe45AhgeIYSg1QoSvKsof
	B/tNIXJwPrbyYyTgxxyilXGv0tO5I1feNI5SZPEquwQusFpMSBugw5Kb/6zDUnuRz5FQPAf1h1A
	iXjNyOGmZM+/TKouGV00lkXbsMm58mUAt1IznjkaQ00p2+U6vcmft0yzSANSIVF/YD0kZfpAguP
	88JI74jKSMmzGonN7OYOgu2+Znj1GoL27/0x0a84PaOsjepAWopZPSK79iH53fy3fwy7b7ozBq2
	B0r/TsJBSrB8MRDeEZdIr12g6HKS0tEvFmAyC73a87BH7iDofRvwGfIHbNuMSsgpeEK/W4hosg5
	lJdbidRWWVs6QRUb/21ZshIRdaE4OQ5iulPjVI3id8Dt4BjM7g7DM
X-Received: by 2002:a67:e703:0:b0:602:91f2:6b07 with SMTP id ada2fe7eead31-602aeca3620mr5338061137.23.1774279063454;
        Mon, 23 Mar 2026 08:17:43 -0700 (PDT)
X-Received: by 2002:a67:e703:0:b0:602:91f2:6b07 with SMTP id ada2fe7eead31-602aeca3620mr5338036137.23.1774279062924;
        Mon, 23 Mar 2026 08:17:42 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:f9a0:d7e2:7eb6:79b5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644bd923sm35936993f8f.12.2026.03.23.08.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 08:17:41 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 23 Mar 2026 16:17:13 +0100
Subject: [PATCH v14 07/12] crypto: qce - Remove unused ignore_buf
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-qcom-qce-cmd-descr-v14-7-f323af411274@oss.qualcomm.com>
References: <20260323-qcom-qce-cmd-descr-v14-0-f323af411274@oss.qualcomm.com>
In-Reply-To: <20260323-qcom-qce-cmd-descr-v14-0-f323af411274@oss.qualcomm.com>
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
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpwVmBkjvocaAYojniYTiJ30zO4t/7HQOAjM8kz
 ejQG7UWQBeJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCacFZgQAKCRAFnS7L/zaE
 w6KRD/oDxII3O6t0HSzep3ZIbunXeSnNyR6xEPumRDe1re5wvXXDvm3sgBvqo+lRd/iPpLL8j7A
 yd1syT0VkOHhVVi79OKCH4x7AxMoFtZRZJWWjfeIcyUVotNDkUG2mRzEDEjMDV6cED0+34ylxdA
 w1f76QTCVNeNKot8ygSLr6yNmq2htWNBIjyoBBbl2W5LbdqI06vRgxIBX2dLZfkdjm33EyNI/kK
 y7IWybYrWzFWG4Haa8tJwPE3R2FmdP9JhtlTmDwYWZKtc1xeKxmOEAvsLLyOQVcyFgQVf+/X8no
 I3UcyyrKNrYiUg1p2vgG/GRoSw916z/RN0gjK7FAy7Dhh4R6IErRcXKYh5QsgznPLH9TLSvnXvi
 i/upzqXHdMrmDsA6Q7UFdTtUxiN8J0BubouaykvM/AIm/XTGVtI12Ah98rrZLqUu5F+04NLIb6r
 k5rsWZUZbQilp/OuBAvTfjyHO3XmcPQlidhwXjlbAlz6ZqAYUQcTg6bMwwEaaZpkTEHiNITKYgS
 4EKzXH033fgUcahGPJqXsr7KN8YSIYejatPS7sKNX5YEOtHsTn0cvtQ+g8S9BAA5MtCb9rHqik1
 7RRdMJeV2XdMRwdwCTF+exBKVAnYGbwATKPnJ3KDbL0g7zbwRnEjtHYO5LuGzS5b1lRPvQ+Mlbi
 Nk32h4d79H8L3lw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=CYYFJbrl c=1 sm=1 tr=0 ts=69c15998 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=tWRRbWwrKX-5tUpmLDIA:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDExOCBTYWx0ZWRfXyKqsAiBLNMTS
 o/WeqZn78qLmRFtILOjv5s6UDqVKPUZrMaSSh9Tkrb/4g9zJljVlUWWQW+n/BSp7zioRd0VYhhN
 EY4AAqdp48o34qPphGQvPj4Pwfb+fBhBaC1KbDhuQeQfu280R5TmSPh5Zim+v+YDaID04OKc7JN
 uUsyGZbPLC/SnU3ZaUhs/k8JfjQfoRbxHc2xmz+07XcZxYpDhq8S0csRV/9M415+tJtzuWnqinE
 aq4huobzSbRi/KZ7e0JiMwHTdIlPATIzl/XWz14uwS1fGTuIlTns8vIxYIgdjtjNgp27z/0R+BF
 cjHOz5tXCyuotXNi//YZE537HXrOLFxthBQzzch0NqalRizB2+3f/gBIfwlj2HLaUKdvqZq5qli
 FhNX46cTgKqhf9O9LBmv9YiK9wCJk5nZOzO/kCtD+hZUK4bwZ2ZLtUTz8RQ1DDJ12Wk0zDJVizr
 kM8xJmNJ9KbIqUUIv9A==
X-Proofpoint-GUID: SRpKTSx3rVg3y6uCVk7U0_FrKA3LEkEG
X-Proofpoint-ORIG-GUID: SRpKTSx3rVg3y6uCVk7U0_FrKA3LEkEG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230118
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9606-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 51C342F6F4D
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


