Return-Path: <dmaengine+bounces-10943-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNzlDaicFWr9WgcAu9opvQ
	(envelope-from <dmaengine+bounces-10943-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 15:14:16 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 360CB5D62DE
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 15:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9C91F301C9E5
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 13:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE753FB7C0;
	Tue, 26 May 2026 13:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oUThSWJX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ybw5wlyF"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686BA3FA5F3
	for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 13:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779801091; cv=none; b=YCTEaJCOc831xbjTc7y8uvZDg+YGvyhJ9IxWQ20qi1whaEeZ+GoCPntSGdOnVKAgI4KeFvN3YPcbwkRqU6r5L1nz/VtJscxMLXUDQ+e51S7sx1lSunO6tQEgg1HwJh8XNXXAbASpu0Tf68r5N0iNhFKsiG/tWdokptvtFUde+Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779801091; c=relaxed/simple;
	bh=szNr7XYlP/RmxhFwkiXdqgSbJMTs5djSMoKrGxWxQpw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bZzE44LUGAVvPR7LtUaJ4+0vjZIavIVtrCVeUpoH/cMCDvsD7UzLvV7FBRQclQrY2K8lmlx77ToLQBaMdtfpy1/qAE9egoJuJEwME/XeAO3Kg644lawjOdpMpVrM9MfFMEuFvGTGSG8T91iadeNlEoyGHXWnBKO0WAYqmLh1jLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oUThSWJX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ybw5wlyF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QD40533693558
	for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 13:11:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vBHLofPVeYPfx1ZGHrhJ7CLmG7Qg01nr7l3iawgtmCw=; b=oUThSWJX0k+LUVnG
	Aeh4v1t1v+5z6edxnBkd5OiNBDuYJZ4F92akANGhGklEtPs21l5JjZZB4oYVymbC
	BdyC/PW5q5sZ79TUk9x2ACWhl9MuzRE19zfP1KHvLB9cZem8/pSOeHmlNt7Kcvcs
	ME5Wb7UvS4OGF+HB9qFIlG7W90xvcZOaJFYg4ucPpN7f1EP0KQRdjhD467BB5Eh0
	gh5rIgrXjdY0eFSzpS16CST1r56k7Tk+MXwihasnMdo7qX6Xj34VJnIfKHsTf5ek
	gZFnb6kkseJySR81w+K0LSbavZo+o6SFnwa+AeF82tfPQe9jLXHAn1t4H8jtRRu4
	ZzZCDQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edc2yg1sc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 13:11:28 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-6618ab427ccso11983941137.0
        for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 06:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779801088; x=1780405888; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vBHLofPVeYPfx1ZGHrhJ7CLmG7Qg01nr7l3iawgtmCw=;
        b=Ybw5wlyFjiG1UeSCh2fmSLF+qomzVWupZtfeV1cDkz/+TeF1Kt8iiH2ohBJcNuTXr3
         THzH0kolwTHRs2l/5L0qEV5oyvckIUwQUIWrOSV1dK3tqkvx88my1x2oShIfmmMJfPqQ
         J5TqMcKhccaQYMl8H/4VlPIaNfo6bYtqri9lzgJ/3Sqcn6EOPqsiAu9Y6hN/TPu1nIc2
         eJmEpGNpJIV9xwil4peT1+FQb7eZUOgD3Nctp9kxAclXW8KOcsxB/oJhyIPx/Duug87m
         C+L9YacMkFBwFL8HCfjDNkCJzh3vyJ0qHjPWXrXHtEgUos3fed9irt8YPdb5qlzsee+r
         mhXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779801088; x=1780405888;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vBHLofPVeYPfx1ZGHrhJ7CLmG7Qg01nr7l3iawgtmCw=;
        b=OLtRpZbxHzTRNkrg5cLXvhNV9NqRyEUo0etx6rvbSv9Sz58MjZ4IWzaO9oymWdOLGC
         TQ0n3A3FwMZeAEkLQVmCoHPc4nTr/GJmvb3lHyT+Jf+lT+S7yaSlyteXPiLPqvnX3C/F
         o9WAGuHKs3JhUO9ulznzVqio0sbMp/zRfgphjoB/7kv1KawpNlroFHe6uzGQdP6AKeVu
         VxklI+IJGSxK+UnYI6C93ZN3L6UxjgLmK8Yh0v6uO3dy7+Wgl4XYeKh/vOQxPN6eqE7W
         WZ22Nb14dN/kj9X2vVlivOItuMoe6Knu2910MRLTd+ItT0XciXRPNktk70R2lmWxCGBM
         vdJA==
X-Gm-Message-State: AOJu0YyeW2Dhp+LyhBHh/K1EcX2FJzg6yM5uhRveVdJyMzBkkjcGyL/g
	zb1F+xw4o6Jfb3pEwFQV/QUlkw0x/jhD8Ji5US8ZcjlOb/WxU5b5/PPEp2IaRMp7CdgCPMBAYs/
	UEnFNzITDzS0W30wQ5lk/WCKR9bmx5nlVK3/h1vz8dJekPElkZ/JGjqAic4zMcxY=
X-Gm-Gg: Acq92OGK14KSV/zhtXhB2JEpVfHptbTy/p2unbxOfEPz5qyvOxzdeM1nzdmdcxCZre3
	PlYf/7dD5leY3oqV2vzUEecv3f15HCu+NPQ0O8pNpgo7ki6fgPdecIWe16hIBbz5CRbjSPUUFlv
	jl8jk25uo1vpMm39RQD2zBy91W/DlWx/quqJnJEQZK9gfG3EwJGClT/JNgncTqVfMCEpkcUjzfE
	Cu9AUX6p8PTCtpDIB6HanjLsDakwyLz1kI3ucunLGyeKPcsLmN1IMmpSW9+feNw9tn8ysU37CCN
	t7T+CQode6p4OJDPbUKHEXz4jOPmWJVkJ7RwvDB9w2aq60JLyeO86onB8zGOpgsP1PIVqV7+EPe
	gY2n/eNFb6MzNST9XCwAS013dZAeXNvPjrR0meMrF/Ke83besF0A=
X-Received: by 2002:a05:6102:6447:b0:631:d445:171f with SMTP id ada2fe7eead31-67c92ecb981mr7787005137.15.1779801087379;
        Tue, 26 May 2026 06:11:27 -0700 (PDT)
X-Received: by 2002:a05:6102:6447:b0:631:d445:171f with SMTP id ada2fe7eead31-67c92ecb981mr7786956137.15.1779801086891;
        Tue, 26 May 2026 06:11:26 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:15ba:1d70:65ea:9578])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d5e484sm34259426f8f.30.2026.05.26.06.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 06:11:26 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 26 May 2026 15:10:52 +0200
Subject: [PATCH v19 04/14] dmaengine: qcom: bam_dma: Extend the driver's
 device match data
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-qcom-qce-cmd-descr-v19-4-08472fdcbf4a@oss.qualcomm.com>
References: <20260526-qcom-qce-cmd-descr-v19-0-08472fdcbf4a@oss.qualcomm.com>
In-Reply-To: <20260526-qcom-qce-cmd-descr-v19-0-08472fdcbf4a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3778;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=uxRjFVxEhrXgn9P1PbRyStGi6yK9KFcQvfp9JiG64Wo=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqFZvrKUL9qIkIN19qHPEpzuE2u/9bNVcl14aWN
 QqSrjVTl+aJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCahWb6wAKCRAFnS7L/zaE
 w1dFD/0cVIC3rGapO0PKyqz7apZd6ma5SpNf5q9iP4D70P+gdIIaivnFTjRV5khLy62rL8tKtiD
 X6NA6JDfEdj7cW4AlYdEvmaVdtCs9onD6Ug6szzgaUyAEB/BkAEIaPgPBx/jgNR0dVSDlV1AQ6Q
 SuDIaG3gdJvzEavdwzuKmGJ7U5e1F0RhGPLVsrPrJfGH2WqQ7KvrXIkuzylTvmC8luChR6vsneZ
 RQVwNPOCJJfoDkz35045GwPpd1NTIofdUImh5xGo/eTc7/5LvMApBCEpUDAPuojV2ghp+H3pVpO
 wEIhCPb6SucKoX+0TizqrOnRE/QdIKTdIQ8mP+KqhG64dCXm06jXch1h31lSBkgV9nTnR6qUYOR
 ckgplFhHkXnZFSsDCIi9scdtHZxQa6zQUMKtPMRQSGx9Jw8xJVE2bhJHLzw7HyJKL/aJICPdy1s
 icQMOFwDWGlfP5TSappPtJpouBTbUIIpJSKIgLGuY3pZaxLsRLZv2vnaBqwv0DVqJbR+50lyk0Y
 1RexXxlbo2Uzz21FflwZKCLfQHG7mOvuDYQyzGqDjQOHRjMgvnBAU1R0Te4JyUoHHbtu71fBYRf
 hQ6uiX33ToVBjIr8MOf/OmpSLcpxcQwFUixfMf1Na7lwH6iPLcno4kd6IA6w5J4n2NzOijXI5LT
 bKeFTl3PBHQGIEw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: _CPWywvANjP2emjabD9ssNqB_wsZgKBi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDExNCBTYWx0ZWRfX3OH0IpyVOb9Q
 Nz33XMQbZj2+Qm/xJA3adOE2H3RQt1yZ6Qrh2KC8NZRla9an78pYyEO9xAtXx2Bjr2/WH9zXDp+
 9VFHZ0nygnrr6fPq6W9tAXPFNLPnH6eINUNjkxpy5HndwlkfZhTihLqYnrkDUHA0ipXZB02v1vV
 uv0JhzsWt2MdAIq2ZPI2NEh7edRazDHgHuBXBUU7kDA5p4q3VEhP6eFVsM+1wTT/5Lj4sQofOHY
 Yn0dr3lKvpLiRBGEaIEkN1lXGx5NU56Hl4P3V5ZbpzGEET8bGQ22LQv/Z+ydqlE/8nCWJIXVKz2
 v815fbbkOQ9v8rt7WwuYzahqXegAa4G5DfB1JDCvAAL1XbGvn/W83jQan5bytWJ9h7D+yDgtc3H
 dlLtGFwozuFdV9cZ+CaJuNGdtoYjJaq98yuE0rH1V8LvCcLIqIjBJDYB+w0XB/tagJueJsEju0a
 CheH6c80/fpdl+8rLjQ==
X-Authority-Analysis: v=2.4 cv=CYg4Irrl c=1 sm=1 tr=0 ts=6a159c00 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=KKAkSRfTAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Fb6uNmSZeVr-t7npd3wA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: _CPWywvANjP2emjabD9ssNqB_wsZgKBi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260114
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10943-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,linaro.org:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,qualcomm.com:email,qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com,codeaurora.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
X-Rspamd-Queue-Id: 360CB5D62DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

In preparation for supporting the pipe locking feature flag, extend the
amount of information we can carry in device match data: create a
separate structure and make the register information one of its fields.
This way, in subsequent patches, it will be just a matter of adding a
new field to the device data.

Reviewed-by: Dmitry Baryshkov <lumag@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/dma/qcom/bam_dma.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 1c62f845ac0b956e311857b93f5b504086662f45..2129ff5261571581a2c086c13dd657dc63e16f90 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -113,6 +113,10 @@ struct reg_offset_data {
 	unsigned int pipe_mult, evnt_mult, ee_mult;
 };
 
+struct bam_device_data {
+	const struct reg_offset_data *reg_info;
+};
+
 static const struct reg_offset_data bam_v1_3_reg_info[] = {
 	[BAM_CTRL]		= { 0x0F80, 0x00, 0x00, 0x00 },
 	[BAM_REVISION]		= { 0x0F84, 0x00, 0x00, 0x00 },
@@ -142,6 +146,10 @@ static const struct reg_offset_data bam_v1_3_reg_info[] = {
 	[BAM_P_FIFO_SIZES]	= { 0x1020, 0x00, 0x40, 0x00 },
 };
 
+static const struct bam_device_data bam_v1_3_data = {
+	.reg_info = bam_v1_3_reg_info,
+};
+
 static const struct reg_offset_data bam_v1_4_reg_info[] = {
 	[BAM_CTRL]		= { 0x0000, 0x00, 0x00, 0x00 },
 	[BAM_REVISION]		= { 0x0004, 0x00, 0x00, 0x00 },
@@ -171,6 +179,10 @@ static const struct reg_offset_data bam_v1_4_reg_info[] = {
 	[BAM_P_FIFO_SIZES]	= { 0x1820, 0x00, 0x1000, 0x00 },
 };
 
+static const struct bam_device_data bam_v1_4_data = {
+	.reg_info = bam_v1_4_reg_info,
+};
+
 static const struct reg_offset_data bam_v1_7_reg_info[] = {
 	[BAM_CTRL]		= { 0x00000, 0x00, 0x00, 0x00 },
 	[BAM_REVISION]		= { 0x01000, 0x00, 0x00, 0x00 },
@@ -200,6 +212,10 @@ static const struct reg_offset_data bam_v1_7_reg_info[] = {
 	[BAM_P_FIFO_SIZES]	= { 0x13820, 0x00, 0x1000, 0x00 },
 };
 
+static const struct bam_device_data bam_v1_7_data = {
+	.reg_info = bam_v1_7_reg_info,
+};
+
 /* BAM CTRL */
 #define BAM_SW_RST			BIT(0)
 #define BAM_EN				BIT(1)
@@ -393,7 +409,7 @@ struct bam_device {
 	bool powered_remotely;
 	u32 active_channels;
 
-	const struct reg_offset_data *layout;
+	const struct bam_device_data *dev_data;
 
 	struct clk *bamclk;
 	int irq;
@@ -411,7 +427,7 @@ struct bam_device {
 static inline void __iomem *bam_addr(struct bam_device *bdev, u32 pipe,
 		enum bam_reg reg)
 {
-	const struct reg_offset_data r = bdev->layout[reg];
+	const struct reg_offset_data r = bdev->dev_data->reg_info[reg];
 
 	return bdev->regs + r.base_offset +
 		r.pipe_mult * pipe +
@@ -1205,9 +1221,9 @@ static void bam_channel_init(struct bam_device *bdev, struct bam_chan *bchan,
 }
 
 static const struct of_device_id bam_of_match[] = {
-	{ .compatible = "qcom,bam-v1.3.0", .data = &bam_v1_3_reg_info },
-	{ .compatible = "qcom,bam-v1.4.0", .data = &bam_v1_4_reg_info },
-	{ .compatible = "qcom,bam-v1.7.0", .data = &bam_v1_7_reg_info },
+	{ .compatible = "qcom,bam-v1.3.0", .data = &bam_v1_3_data },
+	{ .compatible = "qcom,bam-v1.4.0", .data = &bam_v1_4_data },
+	{ .compatible = "qcom,bam-v1.7.0", .data = &bam_v1_7_data },
 	{}
 };
 
@@ -1231,7 +1247,7 @@ static int bam_dma_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	bdev->layout = match->data;
+	bdev->dev_data = match->data;
 
 	bdev->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(bdev->regs))

-- 
2.47.3


