Return-Path: <dmaengine+bounces-10124-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPhxGwYq72n98gAAu9opvQ
	(envelope-from <dmaengine+bounces-10124-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 11:19:02 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDBE46FBEA
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 11:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6680A301B908
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 09:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CA33B27C5;
	Mon, 27 Apr 2026 09:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cG0pc7rg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C7zNro+n"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C252D3ACEF3
	for <dmaengine@vger.kernel.org>; Mon, 27 Apr 2026 09:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777281359; cv=none; b=dmP0soeyUXZ+cCOlnbRfFSAKXgYpxrahL4idhpUuj27IVZeGt4uzNjDBHzKX29lTj7HgObbtWJB48Uz4Tnsx/ypX5Q6ISyyz/lMjFr9kdryC6rwwAuiWSCfHjHfBWVLxXX280koG60Glhcs/DV00plWndF5KVDA6pUHtYeN0XZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777281359; c=relaxed/simple;
	bh=l+LhUeaRtv45iec6oeuNdA/aHnIbTdZoGOvGH+nneDI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ufKPBcgD836G9H2SSbMPf2GZVVuMV07KB4rRdLZPZxwd1FQGY9qZLp5pigem9fQ0L5Vk4VVprKJ6AKFhn/pMEVv4Kl1bg7Ge9sgK46GjbJMzIHYDz/C10RC+q+zo0pXj0+d2YchaQ+9dGUaiRZw8tKLPOov6gio4a+HV2sfXX28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cG0pc7rg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C7zNro+n; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R8TLAi3681853
	for <dmaengine@vger.kernel.org>; Mon, 27 Apr 2026 09:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=BOK3j2CpeQGoKF/Cq3JWj4
	Xhh85mF44tZXeGIjJjZDA=; b=cG0pc7rgYTdSyJW0dtcf0GkARp9a6hQc/E07YS
	PuMycRv3+m5gWoGVX4MqjTdMy/Yf9odUPGgNsQUy/FXV4b/2cjJyv/esYBFr4TPK
	/op5EB58m7HV7HZhw2p21Nz8JhVn/wizR4idl/c0uDdbDegBVi5MIPKkV1hKPYdc
	d4n9v66a0B6pP1QoEyo83bU9aFZFWPhxOaJkAFgSnDviWbA3xptOB/P9f5i4HD4V
	+OOkPymnmwDla/CvofkJEywquiWX6yYlJC4K/DUykN8ULoFlV+i9iF8cynbl+QuL
	uLaoFtLAgvlXL/E4manqrAGc59T3iCqyEKJahXAuSlPLlzMg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drpsgwabn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 27 Apr 2026 09:15:55 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50d84b5f73bso62583161cf.0
        for <dmaengine@vger.kernel.org>; Mon, 27 Apr 2026 02:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777281355; x=1777886155; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BOK3j2CpeQGoKF/Cq3JWj4Xhh85mF44tZXeGIjJjZDA=;
        b=C7zNro+nnqUloiCPXuYj07gBK2wk5sgCv2P4plMdI03BHhqFlvsI4WAjbBBNY9bhff
         t0JaSfpHvuuBnLOKT4VgxAaMuvI6KsvwxpgXm6HKGuVXLCD2i5Jc/AaXadbZjMqbYjoA
         m12XwBs2yVU+bkF4Qr+JrjJGxNj4tdxOnNJ3DFmKJCVKC7JQaFUrC/uPBBy+muxSusP7
         indn0zqn3jI4f01dY1xXL7MGFWWuSDG6MxS7ZWgBfThkgVDuBxCyIzBePIOA3WJzZToS
         hn8+LHqsYHOti8VC2K+5rCYZrAzvH0pDLZkwe2mbJiqipftJ6SSqQBoWPko81C9LD+N8
         Me0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777281355; x=1777886155;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BOK3j2CpeQGoKF/Cq3JWj4Xhh85mF44tZXeGIjJjZDA=;
        b=JQl6xm+07DMETLCoC4dVFHLo8CNkgxnI6lajxqMpFgsgH5rfFGGEdnNDLD9yFovB0s
         UTeJvETMTgtLOlsbHaIVmt5vr3uMnGCf0dBNzEdNqp8k0IvBTFVDyVmtNo2s+RIVSk5G
         ocQxi1xYFvAaBNuYI3+4G409p+cZaQ5KnvhyjN/Pi+25ibFOZPsvFCxtA7CCro/IqNVf
         8rqJ6sPuU39m1yMKB31F5geiqlk3q8zWlPA5adYsj1gVUJy912xMuECYOzvWBbbl8qVM
         zXiIdaeMirrQu/8HsqvVhbiL8EYGhJYdvPMzIfw/tRkcCb2Wf1sGGiqATm8kADobicxK
         /i2A==
X-Gm-Message-State: AOJu0Ywd1q0eMZfT8vicAN1QzoiWcmycsKTe6tbn7iql7MUQof9l87d+
	8PwVA1Aj/vkm+nm9k1MKnA/2gPMHcATE9ZLO7cKO3qDSFXxdnIpdoSLKw7EhOgjHudLsuXsA15W
	jjWuOOgPRaliXtYkWm8mpF/i/mQ9787+ubt+plObGA8KcN0RKfUHa65DF9nVsvzY=
X-Gm-Gg: AeBDies0TCqB0mRPP5ZjLyOC7/lrOltvc80SJMaT1IKpaa0fZgOOsr/k5KapCsk1u7g
	rK+1YNQXM7/MF6yvRMQmPMcsjKnFv/qJLAaYRRbCv0hkv1e7p6X/cYtLd3o4KDm8+6UxJ895oTO
	LLsUMs6Ui1Gc6qXLrA7JLNxC9jHKPZabRjBtaEIo+Fts46XVUIft6xk0GlPNov0BgensxtmeVkN
	TOJpDxf6SaX4JnpzK0IQAWS+n+/aLBZfImAw/qEdxXAYugEBw4U2tB1ENLTLp9mRJcx2CiHnxKs
	totgUUfUdmtJ7G8ET6HxQcoyOHT5m3a7PWNsP/qM8KO6RtWkGpF9WFk7qh+CFyVUtR7j1OshWRX
	OI0sAwV4kR/O0rLsLDMlCX1UPAuiXDkn99Ib+YWUzKyxC5mktMCThH9Kp/dFrnQ==
X-Received: by 2002:a05:622a:458c:b0:50e:41fd:52e with SMTP id d75a77b69052e-50e41fd0867mr451446421cf.37.1777281354797;
        Mon, 27 Apr 2026 02:15:54 -0700 (PDT)
X-Received: by 2002:a05:622a:458c:b0:50e:41fd:52e with SMTP id d75a77b69052e-50e41fd0867mr451445981cf.37.1777281354279;
        Mon, 27 Apr 2026 02:15:54 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:5062:ae86:23aa:702c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a6dbfd4b5sm40559365e9.28.2026.04.27.02.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 02:15:53 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v16 00/12] crypto/dmaengine: qce: introduce BAM locking and
 use DMA for register I/O
Date: Mon, 27 Apr 2026 11:15:33 +0200
Message-Id: <20260427-qcom-qce-cmd-descr-v16-0-945fd1cafbbc@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADUp72kC/3XRzWoDIRAA4FcJnmvQ8b+nvEfpwfUnEZJso+3SE
 vLunQ0NWah7cGBG/ZSZK2mpltTI6+ZKappKK+MZE65fNiQc/HmfaIlYIMBAcc4EvYTxhCHRcIo
 0phYqDSq5gfOcNHMEL37UlMv3XX17x/xQ2udYf+6PTHauPjjd4yZLGU0hxuBB4NK7Yzn7Om7Hu
 iezN7mFAbZrODScV9nAYJ0B+Gdw9kSAuy7CGSo5mySHbKKPcje2tr18+SMePm0x/Fn8YWkmGPQ
 tjhY6PKs4SMtgzYKFhR/oWoCWcDYLk0GnzNYssbRM3xJoMadtGmS2Qa5acmGB6Fty7hfu+ixxM
 ma1X+ppybV+qXmCdlBCc5xANB3rdrv9AnRnHp/CAgAA
X-Change-ID: 20251103-qcom-qce-cmd-descr-c5e9b11fe609
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
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10453;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=l+LhUeaRtv45iec6oeuNdA/aHnIbTdZoGOvGH+nneDI=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBp7yk4flev8z0MSfrS5ohRlXTrDzcvcsYS4Xy+s
 5FNcGBcJQaJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCae8pOAAKCRAFnS7L/zaE
 w7VcD/9mE6v5WZFStUx7CwlQ629dwNzMyuNMtojhCUI5LZ5nLHhLXX6EmSnFcl85QjvC2BhANwo
 Xpd/JuuBe72ZTXWQ5CjLv50Xm8R15tl9bk9UPxFzWlEtNBpaKOKF+z4ZW0qMEebgGiCkv+alNLy
 w057l+CNcnyH1RQk590WwVRo0Ip3HqxMhO9sE2+sNcAL5FUd2+cfu6BzMmbmPsheJ9WPpOa6rHS
 faosm7DHjoz7Lq4vUWJoxkKU/CU/iC5tkYI54lqoRqhK6DQX0ROY+BHM9BZldT5JU2rZrcIPwrP
 mUpjE5wsHziszVuIYeN9WK7u73dXAElAg49XZ3KJdhMeVZk9kiOnIU8/ifF0S5d8E2X0ae9ZEyZ
 N3NM3uSFrl5ObHTohjApeD5hfkA4Mjxcejews3eDgiGVjmPnUd3K3yNnv/dxx065qN+ho9q/pwP
 /TjCKLZO6L0tXIqPevT3LB70IZQL79bOPhk1dbazhnqC1+8g/NSu00VCRXLEa61sU9TXEsRIC9d
 xKWCQQpqcjHE7IBOLsI0W95jBJ6tNRShaLbAWPqwkb2MnzxRrwz/Qo2BrAqEMCBS8cKrrigvMiJ
 sWlToW66fJQcrI37rpBSazR87KcyMhAuF7qrnlwvcarlHWCSvxIlHK5n9Oao8Hs9f1RkraWXnnY
 i0l+cT5TDJRQqVA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: JOBO_ygjcegZRqfFgg1FalL58cIQlY-V
X-Proofpoint-ORIG-GUID: JOBO_ygjcegZRqfFgg1FalL58cIQlY-V
X-Authority-Analysis: v=2.4 cv=Y+fIdBeN c=1 sm=1 tr=0 ts=69ef294c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8
 a=NtJOnDUUI7_CwCB1VzYA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=FO4_E8m0qiDe52t0p3_H:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDA5OCBTYWx0ZWRfX3Q2yj1kUgsT3
 lcIvsB2xPnF0bgWc1Yln6b02CKs/anVm5wvmz1t2Pr29JJX/LPPFDgjc+qf4LvUCKt093nWR9YL
 RLjRAgN1bZ69MrjyPT/amOcSkcfoZut6gLmHHAb+kRujOnlTnWU3pA0BJ7eS49lfStgscFwAs70
 ovRUxYqAr6XdRVmM7jwtVqSvPbqJaQmQCwgz0tb6QAoqCbh+rIUsto0NYhhIXaL+c/q+yv69/Vy
 J+NS5tP2BJI4pHkGx9cw2EvCCPdF9IuXy2Qm6z6Z9BkGp4LK2j+n/ebCzMlUpvAWyihHLDpsEpx
 vtx1eAgje2zoT9lz913V2k9nuR0Gn4AOwE98apyRnKeKgcHbdzcP5zySLYn4IBPCN70ewEj6rnd
 JlEjtxlYqR/A52EEubzMhDNwRWbE1iI28raqjZ4sqXwNLzLc0HrnTyZjK59aBWqZ1t+B4Q0T5TY
 heF/rf0cKXbC4+vUpIg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270098
X-Rspamd-Queue-Id: 0DDBE46FBEA
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
	TAGGED_FROM(0.00)[bounces-10124-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linaro.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
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

This missed the v7.1 cycle so let's try to get it in for v7.2.

Merging strategy: there are build-time dependencies between the crypto
and DMA patches so the best approach is for Vinod to create an immutable
branch with the DMA part pulled in by the crypto tree.

This iteration continues to build on top of v12 but uses the BAM's NWD
bit on data descriptors as suggested by Stephan. To that end, there are
some more changes like reversing the order of command and data
descriptors queuedy by the QCE driver.

Currently the QCE crypto driver accesses the crypto engine registers
directly via CPU. Trust Zone may perform crypto operations simultaneously
resulting in a race condition. To remedy that, let's introduce support
for BAM locking/unlocking to the driver. The BAM driver will now wrap
any existing issued descriptor chains with additional descriptors
performing the locking when the client starts the transaction
(dmaengine_issue_pending()). The client wanting to profit from locking
needs to switch to performing register I/O over DMA and communicate the
address to which to perform the dummy writes via a call to
dmaengine_desc_attach_metadata().

In the specific case of the BAM DMA this translates to sending command
descriptors performing dummy writes with the relevant flags set. The BAM
will then lock all other pipes not related to the current pipe group, and
keep handling the current pipe only until it sees the the unlock bit.

In order for the locking to work correctly, we also need to switch to
using DMA for all register I/O.

On top of this, the series contains some additional tweaks and
refactoring.

The goal of this is not to improve the performance but to prepare the
driver for supporting decryption into secure buffers in the future.

Tested with tcrypt.ko, kcapi and cryptsetup.

Shout out to Daniel and Udit from Qualcomm for helping me out with some
DMA issues we encountered.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Changes in v16:
- Fix a reported race between dma_map_sg() called with spinlock taken
  and the corresponding dma_unmap_sg() called without it by moving the
  descriptor locking data into the descriptor struct
- Also queue the TX data descriptors before the command descriptors to
  match what downstream is doing
- Tweak commit messages
- Rebase on top of v7.1-rc1
- Link to v15: https://patch.msgid.link/20260402-qcom-qce-cmd-descr-v15-0-98b5361f7ed7@oss.qualcomm.com

Changes in v15:
- Extend the descriptor metadata struct to also carry the channel's
  transfer direction and stop using dmaengine_slave_config() for that
- Link to v14: https://patch.msgid.link/20260323-qcom-qce-cmd-descr-v14-0-f323af411274@oss.qualcomm.com

Changes in v14:
- Don't return an error to a client which wants to use locking on BAM
  that doesn't support it
- Add a comment describing the DMA descriptor metadata structure
- Fix memory leaks
- Remove leftovers from previous iterations
- Propagate errors from dma_cookie_assign() when setting up lock
  descriptors
- Link to v13: https://patch.msgid.link/20260317-qcom-qce-cmd-descr-v13-0-0968eb4f8c40@oss.qualcomm.com

Changes in v13:
- As part of the DMA changes in the QCE driver: reverse the order of
  queueing the descriptors in the QCE driver: queue command descriptors
  with all the register writes first, followed by all the data descriptors,
  this is in line with the recommandations from the BAM HPG
- Set the NWD (notify-when-done) bit (DMA_PREP_FENCE in dmaengine
  parlance) on the data descriptors to ensure that the UNLOCK descriptor
  will not be processed until after they have been processed by the
  engine. While technically the NWD bit is only needed on the final data
  descriptor, it's hard to tell which one *will* be the last from the
  driver's point-of-view and both the downstream driver as well as
  the Qualcomm TZ against which we want to synchronize sets NWD on every
  data descriptor,
- Revert to creating the LOCK/UNLOCK command descriptor pair in one
  place now that the NWD bit is in place,
- Link to v12: https://patch.msgid.link/20260310-qcom-qce-cmd-descr-v12-0-398f37f26ef0@oss.qualcomm.com

Changes in v12:
- Wait until the transaction is done before queueing the UNLOCK command
  descriptor
- Use descriptor metadata for communicating the scratchpad address to
  the BAM driver
- To that end: reverse the order of the series (first BAM, then QCE) to
  maintain bisectability
- Unmap buffers used for dummy writes after the transaction
- Link to v11: https://patch.msgid.link/20260302-qcom-qce-cmd-descr-v11-0-4bf1f5db4802@oss.qualcomm.com

Changes in v11:
- Use new approach, not requiring the client to be involved in locking.
- Add a patch constifying dma_descriptor_metadata_ops
- Rebase on top of v7.0-rc1
- Link to v10: https://lore.kernel.org/r/20251219-qcom-qce-cmd-descr-v10-0-ff7e4bf7dad4@oss.qualcomm.com

Changes in v10:
- Move DESC_FLAG_(UN)LOCK BIT definitions from patch 2 to 3
- Add a patch constifying the dma engine metadata as the first in the
  series
- Use the VERSION register for dummy lock/unlock writes
- Link to v9: https://lore.kernel.org/r/20251128-qcom-qce-cmd-descr-v9-0-9a5f72b89722@linaro.org

Changes in v9:
- Drop the global, generic LOCK/UNLOCK flags and instead use DMA
  descriptor metadata ops to pass BAM-specific information from the QCE
  to the DMA engine
- Link to v8: https://lore.kernel.org/r/20251106-qcom-qce-cmd-descr-v8-0-ecddca23ca26@linaro.org

Changes in v8:
- Rework the command descriptor logic and drop a lot of unneeded code
- Use the physical address for BAM command descriptor access, not the
  mapped DMA address
- Fix the problems with iommu faults on newer platforms
- Generalize the LOCK/UNLOCK flags in dmaengine and reword the docs and
  commit messages
- Make the BAM locking logic stricter in the DMA engine driver
- Add some additional minor QCE driver refactoring changes to the series
- Lots of small reworks and tweaks to rebase on current mainline and fix
  previous issues
- Link to v7: https://lore.kernel.org/all/20250311-qce-cmd-descr-v7-0-db613f5d9c9f@linaro.org/

Changes in v7:
- remove unused code: writing to multiple registers was not used in v6,
  neither were the functions for reading registers over BAM DMA-
- remove
- don't read the SW_VERSION register needlessly in the BAM driver,
  instead: encode the information on whether the IP supports BAM locking
  in device match data
- shrink code where possible with logic modifications (for instance:
  change the implementation of qce_write() instead of replacing it
  everywhere with a new symbol)
- remove duplicated error messages
- rework commit messages
- a lot of shuffling code around for easier review and a more
  streamlined series
- Link to v6: https://lore.kernel.org/all/20250115103004.3350561-1-quic_mdalam@quicinc.com/

Changes in v6:
- change "BAM" to "DMA"
- Ensured this series is compilable with the current Linux-next tip of
  the tree (TOT).

Changes in v5:
- Added DMA_PREP_LOCK and DMA_PREP_UNLOCK flag support in separate patch
- Removed DMA_PREP_LOCK & DMA_PREP_UNLOCK flag
- Added FIELD_GET and GENMASK macro to extract major and minor version

Changes in v4:
- Added feature description and test hardware
  with test command
- Fixed patch version numbering
- Dropped dt-binding patch
- Dropped device tree changes
- Added BAM_SW_VERSION register read
- Handled the error path for the api dma_map_resource()
  in probe
- updated the commit messages for batter redability
- Squash the change where qce_bam_acquire_lock() and
  qce_bam_release_lock() api got introduce to the change where
  the lock/unlock flag get introced
- changed cover letter subject heading to
  "dmaengine: qcom: bam_dma: add cmd descriptor support"
- Added the very initial post for BAM lock/unlock patch link
  as v1 to track this feature

Changes in v3:
- https://lore.kernel.org/lkml/183d4f5e-e00a-8ef6-a589-f5704bc83d4a@quicinc.com/
- Addressed all the comments from v2
- Added the dt-binding
- Fix alignment issue
- Removed type casting from qce_write_reg_dma()
  and qce_read_reg_dma()
- Removed qce_bam_txn = dma->qce_bam_txn; line from
  qce_alloc_bam_txn() api and directly returning
  dma->qce_bam_txn

Changes in v2:
- https://lore.kernel.org/lkml/20231214114239.2635325-1-quic_mdalam@quicinc.com/
- Initial set of patches for cmd descriptor support
- Add client driver to use BAM lock/unlock feature
- Added register read/write via BAM in QCE Crypto driver
  to use BAM lock/unlock feature

---
Bartosz Golaszewski (12):
      dmaengine: constify struct dma_descriptor_metadata_ops
      dmaengine: qcom: bam_dma: convert tasklet to a BH workqueue
      dmaengine: qcom: bam_dma: Extend the driver's device match data
      dmaengine: qcom: bam_dma: Add pipe_lock_supported flag support
      dmaengine: qcom: bam_dma: add support for BAM locking
      crypto: qce - Include algapi.h in the core.h header
      crypto: qce - Remove unused ignore_buf
      crypto: qce - Simplify arguments of devm_qce_dma_request()
      crypto: qce - Use existing devres APIs in devm_qce_dma_request()
      crypto: qce - Map crypto memory for DMA
      crypto: qce - Add BAM DMA support for crypto register I/O
      crypto: qce - Communicate the base physical address to the dmaengine

 drivers/crypto/qce/aead.c        |   8 +-
 drivers/crypto/qce/common.c      |  20 ++--
 drivers/crypto/qce/core.c        |  28 ++++-
 drivers/crypto/qce/core.h        |  11 ++
 drivers/crypto/qce/dma.c         | 163 +++++++++++++++++++++++------
 drivers/crypto/qce/dma.h         |  11 +-
 drivers/crypto/qce/sha.c         |   8 +-
 drivers/crypto/qce/skcipher.c    |   8 +-
 drivers/dma/qcom/bam_dma.c       | 217 ++++++++++++++++++++++++++++++++++-----
 drivers/dma/ti/k3-udma.c         |   2 +-
 drivers/dma/xilinx/xilinx_dma.c  |   2 +-
 include/linux/dma/qcom_bam_dma.h |  14 +++
 include/linux/dmaengine.h        |   2 +-
 13 files changed, 404 insertions(+), 90 deletions(-)
---
base-commit: 06ae5ec2a5f35da6b24d404d16310ee3553dba6f
change-id: 20251103-qcom-qce-cmd-descr-c5e9b11fe609

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>


