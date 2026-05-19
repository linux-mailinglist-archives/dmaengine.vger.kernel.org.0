Return-Path: <dmaengine+bounces-10543-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIykBeljDGpXggUAu9opvQ
	(envelope-from <dmaengine+bounces-10543-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 15:21:45 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3415257F825
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 15:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9C20930213BF
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 13:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C2D3ED3C2;
	Tue, 19 May 2026 13:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wpp7bdD7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RSPEBmbI"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449B84EA36A
	for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 13:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779196708; cv=none; b=EHg2NFjsjFgvbdJ68+fnXTrFckRo3VKuzflxXq9y0DUY/xTBpNwlu02y1ncnWOFm4RN49xHJkXsAw53r26HM81wOYdjt/DPh84hhsno60yn0tpCbCMFZsbJWXxqBjBySEEmzyKjD8j/q0KcK7AEZTUmIiOd0c+vmPPrjiFzEHHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779196708; c=relaxed/simple;
	bh=i/hee7JvrUVQKgQBcZArSmkn8SGmb1u4xa8efxbKLTk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D2hJZk5SVsr7wVdKT+se8+qzc9oJVCbnkT9gO+o7DCa2AoppHx0jyrcNMxUYAJni2mNrCqwxrGS+Wi+NA2shFcKm3NQmbC6b50S5u4ersPIdmxEyc+1utAvB3w/r7S4vver77RBrnG/LBrWbeDJixWEUuIJXy5mPupkMMj1Sofc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wpp7bdD7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RSPEBmbI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J9Lquu4062989
	for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 13:18:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ntxg0h8brd5Zc8YpW5fnE29VKbWAlpqls1uKilqWgRI=; b=Wpp7bdD7iDoC4I38
	aiPh4ic3YWuhFlkZSOFbiW+wWkkN3pDFK96/UYn2CunmxadYtELhHGPUd9U8GMfg
	QeG7IkA2xhGomE0b6gED832EVHwPplQtIoslT7KRtcesGYIMZ15aCpHJzttJ6sD6
	OQ1ENe4MaPQxsgbj1/jFpuTvlfkE6fA74ZSpcsMXKP9timFJd0wK2fzF1PPnMw7A
	oSn7EUj24knHVSgMoKkS+4/I9WZp9uC2zre+EwZJ6RrDCmT9CH1vO4Q3Xpyeqker
	5qn/b6NwF8kWB/wIjFifI6j51+aSaktOt2n+RjtFf3V0hlWKg2W4R3P6xegkiIIr
	ZIEgRg==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8n5u0vm2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 13:18:25 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7deb9de359bso6298203a34.3
        for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 06:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779196705; x=1779801505; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ntxg0h8brd5Zc8YpW5fnE29VKbWAlpqls1uKilqWgRI=;
        b=RSPEBmbIOoGKpavHQ6lXwIS/2KowbHss/kcVao94NIlCsOMaHeo9FwIH4y966sL6A+
         NNTJ2h4Ll74aodSWAXE0s+/gMlyeqKFK3L9Rg0z3YDBP6+DTucjfceeDN0n2jv8owR5I
         eHLN3fKEALjUbSf6GtbmuLWLZoWTu9FxmhAVJjQXMLRtTqVkaiC+drxyzRoAU5zgpX8f
         0LzcpC5+TBV4ahGYQyKNhzeYT5R59MTA4YfLORghY89gko+MgZLN2tC07MVMg7eCxAhl
         sDIRYWp81LX09p1ymZs+7iPLFinsskfCH5fEghoxxiOkbt8nSR3rgDbvPt2mkmXv/QyJ
         EChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779196705; x=1779801505;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ntxg0h8brd5Zc8YpW5fnE29VKbWAlpqls1uKilqWgRI=;
        b=hZcqQfHsUSJ/OqUePhDrJTxDnti2H592yYE8HAV8Hc/0PcRIwbeqXsqnHNan0MDd4p
         rjAZZm/RzhyIZ2Mfj1yPEe5Au80gAPPnl0Vsa8MTl2Viz3LtwUFu9VHYIJA3jMR+xmnp
         YZguvTrXsj7dlOFpJTl+ybpkk01kBclSZOgwoguZjhpq7RjVM2HipuCqZzFrkQAWM9NS
         BNleMvKRtR0uoPsoh5IFoNvUApZ3m9IrARSCMD5lc7BZnM1oXf4bExzTwi8oiccbkPPd
         EXtbhQDvsPYdjWPn5r8nd9F/on0z3KTeHTJrYnf8o+sQgYMwtsElIkO1u8RoZ/i//nnv
         d0bw==
X-Gm-Message-State: AOJu0YzsFTwTg/2LvusW6K/FY8Hc5dO6KEVQGkwlwo+50bPB01TC9slj
	62CySTECDuUHyJv1TWzlIdA1O6JX6B2LFL8R8eTJuAK10MNdbxtkte0EnQLVRLPsY89v3l5dvA/
	gz0WK4M0/QOvlTypPPKH2pRk938gFTqTaQn8Lu+o3ZtStkqYi4BPgUn7n+wkVhTA=
X-Gm-Gg: Acq92OESABB8HysZ7mB407w9736FJJo8syYxvshk2mKcq1/rRFcMOoIjTDr+La/O+88
	wIRb3Q1d+vrHu9HPBPhAEm0G5BKli/BNjr6zONJ1L9iidavDKJA9TXdSVaIslqGn+iV+pCdHK77
	u2nujxGZXG90pfJjN/IhdD4ui8dQpL4bC444Jho+hTu4JbvamQ/93ySFnQ+e8sMy5buw21P6cc7
	k7tM11Rp1yfXcGCFajnh01w0NxCt40jdWfyXdAIM38Z+EepV9Uugi+WphKZad/vTjyCKSfL22Rq
	STVJNHpY0knN0igAV1LvSEPElKMr+1wS8/QsNeuZDjqGwfTY3xdT2TwA3ZiKC1jI8Q8t/TXfqhY
	6HEHFC13VVuedEVwAVb6bImRxJDZkEvraSX42cCE1lEZ5f3yC+3Y=
X-Received: by 2002:a05:6820:2210:b0:69b:8ff9:f582 with SMTP id 006d021491bc7-69c942ea069mr12773837eaf.14.1779196704867;
        Tue, 19 May 2026 06:18:24 -0700 (PDT)
X-Received: by 2002:a05:6820:2210:b0:69b:8ff9:f582 with SMTP id 006d021491bc7-69c942ea069mr12773803eaf.14.1779196704457;
        Tue, 19 May 2026 06:18:24 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:3fb6:74e3:3c25:ba2f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe7dd22sm143969195e9.7.2026.05.19.06.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 06:18:23 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 19 May 2026 15:17:50 +0200
Subject: [PATCH v17 08/14] crypto: qce - Include algapi.h in the core.h
 header
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-qcom-qce-cmd-descr-v17-8-53a595414b79@oss.qualcomm.com>
References: <20260519-qcom-qce-cmd-descr-v17-0-53a595414b79@oss.qualcomm.com>
In-Reply-To: <20260519-qcom-qce-cmd-descr-v17-0-53a595414b79@oss.qualcomm.com>
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
        Michal Simek <michal.simek@amd.com>, Frank Li <Frank.Li@kernel.org>,
        Andy Gross <agross@codeaurora.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc: dmaengine@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        brgl@kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1314;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=gp3ozjJqNmPcKgZWuLmeZiKenwHgr/5p/hE4XK3neEo=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqDGMJEm+/I7jaukvMGFVKNTuI1fcVuKpYxWb+z
 EhXy4Ob8CyJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCagxjCQAKCRAFnS7L/zaE
 w0kDD/sFScbmmtz15PotswAR9YiIMUnrxV8XlWAaQrjE/X9I56qxQn0geSxVIOi0vlJVOkYfNKH
 h62TLU806m3MLp2yxzgc6zLaVPeDMc3aspdFE9y78JhaAO5tHEZePfCxirCTcFadJ0Q3qfJWHKT
 fGg8H3oDxEOAuwcZGaYN/NgcV2qMogjNjozLyEwe7Res4GS9EPC8ECE16wkMHyKXapUjo/zVxSh
 uHKh/n5/1JqFoJorSH/6vVzrlwQge/mwrMU3duAmpyVJjZmpAqLORLN9gxavRKbSdhC/+9nHcgv
 sMPbOo5V2fyLqDbBeDgT2/XqptGcjEFStiPoX7JY2THmWyQ1o9ZGwiZnd6uYGle5YiTSgQssAlk
 MACTDu/d6RkAPftlKNt7UyX2ZfjSZKYt8PlEd41aUj0QCj9g3m8OjU28XtYwnlZldOXeCaaw+ZX
 mmz8d68fkK2vgRIDQLtGXMLz1wdYLNxHFqawyL9NUnPS1wuUjN9YdDvR+ZVjawLcoqfbDIT/r1w
 mE5ustcH122bjCpa9uLJaLVDtKXEAd73kvRlAk9lIa29pzBo37wK0gxK+0XNsFcyyOfrqbwgLAO
 JUjtVG3+lm3oSp6D5IAzE6Jwi5PT3bEuwwq1XStAb5RvhTl8x6Gjcsfl6ikS2igyTROyt/LyEN7
 FNVg7zAa6cEqO0Q==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=MfBcfZ/f c=1 sm=1 tr=0 ts=6a0c6321 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=KKAkSRfTAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=rvG61WhHFVBzVmnuldcA:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: brj6llFwdyhTUxfxMQP0JO0px34Cxh2Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDEzMSBTYWx0ZWRfXz9m3ONerYlF8
 D3Srync4CTzyPAysc5pEv9vhUYIeMPRWpkFrZkEkrSCX2Llr73NdUeiWzb4cu4X28+K8qs33kTF
 KRkZW1swqyVbQJ5ZDRThAL8pjQl3wmx7sBEcceQhCuNOkFB2C2z4NstUUMoFDA0qQpkFqgDowuE
 D3s7LANd3KAL1LvnhVocB71uRuh4CKcm9MeqLB9fsjeGdpjaprDpaan9j82t6KfIerB+vP/k+03
 He0vy9GUKKGIiUot5DAt+bGE8Czj6QsshhQIdi07rCRqWN7eKyb/yMxmTyRny7vHtwVLKWMsCUo
 cIzGzkWN+B4pre1qLW80ctmsKCLwWtfZqzu/iloyx83KPHB4RHTg1E/0XQrPSA5wT5kBp4Scmsa
 w+ZEK2H7bKtwW4yoUv2+kC8wNaPDmUY2Ofnk2Z2xfKDGqk2IlOLTuZTxZGYPBY4cQ3NsLzDtEgO
 1zykw7xgx4fz3VrqLEw==
X-Proofpoint-ORIG-GUID: brj6llFwdyhTUxfxMQP0JO0px34Cxh2Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190131
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10543-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com,codeaurora.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,linaro.org:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3415257F825
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The header defines a struct embedding struct crypto_queue whose size
needs to be known and which is defined in crypto/algapi.h. Move the
inclusion from core.c to core.h.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/core.c | 1 -
 drivers/crypto/qce/core.h | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index e82fc862c74b20c34ea5abd6c0b98b71089a3fee..5f724db7c65930991218557394d99574418fb68c 100644
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


