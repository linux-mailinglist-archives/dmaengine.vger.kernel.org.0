Return-Path: <dmaengine+bounces-9857-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJKQIhyFzmm4oAYAu9opvQ
	(envelope-from <dmaengine+bounces-9857-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 17:02:52 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2928C38AF32
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 17:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EE3730699A9
	for <lists+dmaengine@lfdr.de>; Thu,  2 Apr 2026 14:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124393EF0CC;
	Thu,  2 Apr 2026 14:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MEj2w91D";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PphoQBgY"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90733EE1EA
	for <dmaengine@vger.kernel.org>; Thu,  2 Apr 2026 14:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775141760; cv=none; b=l/Vaur3plrXi+19O28FWXbOzU6U+/x/rnBUxo1hMlI8+WZPFQJ2/b46xPdj/iyXzwweZMInIn67QNfdaMJcybKWOk9hmaQvKqAtPo/bRQliHljBNsFDjR1VCVB5NBFex/vzS2NgZqPXLtJnaCa+dtoexDNmEVZn0kYscePGrbV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775141760; c=relaxed/simple;
	bh=YERqA6ytYIBXeEnEVHuNkc6pRniKdplpfqUBYqgG5Qg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DTLULNdhlLR/DdGzd1wwu0C6qkRAC9vOIt6kDMJL/Fb5l0NlaC26WPO3Tv20vvKxH0i8Cg58RSfmnZHlbk5AyKDCQU+UZYsrS62V2UY5RT+M1mO/fshdFcK8QNKmaHe71AyvOoMc5T4Sk6tWd9kKyYU8nULt+j+xP8iJrqwR8fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MEj2w91D; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PphoQBgY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632BlIPp2337939
	for <dmaengine@vger.kernel.org>; Thu, 2 Apr 2026 14:55:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YJhp9RjB1CYlks4dixIKSaB1cc2NAImnrh4QNBeenlY=; b=MEj2w91DidZrVNCt
	x5ou9ZYnlt+bQtSBgl7CXV5ssiWW9aMTebaPLvL6xd8cnlGkoE4xoCIQzLw5WkvC
	2SyX6AhSgPxQAFkKym3mikjT8BJVbSsxmwhYLbxmxXkEGdbvZX3Wjko5ESkqId8B
	Hlwc/9oxmstCHiuV4qfQt3C/NPEY2msZBNWmiRAG2yAdt8DIr45YHjXDtcvav99K
	2VpL8Ypyt5jPNzA95A3EhUVtBowS/a8+QwvA+zE1GFXqrxkjd9h0T/SsGTKnDtoK
	epJ2oRDAxHulr8/dPDuWCorQmq1jLmI2AmeSkpylcz6lHRXKnWpVjW5cFSzWCYYM
	eTMscw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9qw08sge-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Thu, 02 Apr 2026 14:55:57 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50917996cfaso29857501cf.0
        for <dmaengine@vger.kernel.org>; Thu, 02 Apr 2026 07:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775141757; x=1775746557; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YJhp9RjB1CYlks4dixIKSaB1cc2NAImnrh4QNBeenlY=;
        b=PphoQBgYcydYJBTqoIIIDkPl3gy8kBwhLSeb9648QnWz5s20cwvt4sBScdrY3E09h/
         zNDxnatMXZL6l/iSMV2eMCK0lkA22bNSnr8GBIZgtGm3pnX5gjcpVHn5PHMJdEvvtJSg
         zI/hoZ6rlKsBOGD0Ipy+N4KiD9kmCWe9y3sWjcMVXqPyNfF+8opyqLZHGxCrKCvbAJM1
         rKUPM+U2ouTVRsbZPG8NJceJFuOKjUZZbGIuuPieBFVIReA+pL2XxOfqnrwzCnByTUYR
         kRDfDQv8HPROBYmp9CMSmA5pNACUE8n8c3dD0nvYpks0eBT/8ke71wraRPEImNAzTeEJ
         gBZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775141757; x=1775746557;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YJhp9RjB1CYlks4dixIKSaB1cc2NAImnrh4QNBeenlY=;
        b=p3WxTMjzPE2kWlAhZtqgrcLhTcaMGaI4PUTNSX9yS8HtIJmAnEgxvyMULvnUYqnEhB
         TmxdsxNawOb0lZYy5R6Gj4mKWHfmNQJC213shIagr069s0B7neXZU+1r/LaGRBhhrvqY
         DnkF8OKYqT/GGHdMh+3UWx6lruD39CMUNFM/CKyj97W9KONZqzs53VC7tHY3b6EmVOzj
         oaOIKTAiN5AzcKcpB/nFDUNsNn6kv4adW0JoSLtZ9xWkys80M8bsY6L3zzai31SW0S/A
         XSneq5Uh5W/WeRNFFZd8QgO/zRT5+mPHrWQRXqzvsOAWJyxm4U6lppyvScJRcMutuf68
         p9eA==
X-Gm-Message-State: AOJu0YyN5BESKAPB3k4oPEwyuJD9c6RWnh3OQuMH0U6L3rqtIFMAPz44
	64Fyqw1kja2OF5Jvfr7H2ZblFfyZEEY4VLqLbQJVbqa1vou4+sQwOOrp9BlnlUTEFI4ZJz83UbY
	cIQlhlbdALQdpbJav62s/n2OGc/ijx9YT2rm7pmS5rDQhSCw1X+8lxbfgI0Wn5KY=
X-Gm-Gg: ATEYQzw8IRbba5nAqzKXY49qYnGajGp0EAK+XKd5aBDCqNpDOnu2VWHgAN4DJYzx6Yo
	yi7uFFTYoiulhouG35GCM9rV+jhECMq0Ltqkqwv2W0iXCq4xSckyFjijVNXLiZExtLqq/XtnQSM
	xSI0nvGwndy8MGgTAWbTKsmhdgfaREYqVf7UB5edxfgn2eqciL0fmlyEC3ZkBCM+n+EdVKAKHeM
	Ay8NFI4EojuxcDeVWS97BN/Sg67qB2LAhIr9FlqYETQt6tfF2Fh+3N7PuwTHNV1QUUezNzBIF3u
	RksPA+26V/Q7ljQT0JvJYaenjF647YKMlDpofuUfLLwo11JfQvt1We9Njtni6D74tR7m99qIqjE
	2h4/RulUUbLE45YErBvnYpjTrVLMDUaK+rCwbVPysw7E4RKkISF8R
X-Received: by 2002:a05:622a:1345:b0:50b:5402:62d with SMTP id d75a77b69052e-50d4b995f71mr54639051cf.11.1775141757079;
        Thu, 02 Apr 2026 07:55:57 -0700 (PDT)
X-Received: by 2002:a05:622a:1345:b0:50b:5402:62d with SMTP id d75a77b69052e-50d4b995f71mr54637721cf.11.1775141755389;
        Thu, 02 Apr 2026 07:55:55 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4ff1:3e57:22ec:dadc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4f5294sm7234038f8f.35.2026.04.02.07.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 07:55:54 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 02 Apr 2026 16:55:13 +0200
Subject: [PATCH v15 02/12] dmaengine: qcom: bam_dma: convert tasklet to a
 BH workqueue
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-qcom-qce-cmd-descr-v15-2-98b5361f7ed7@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4421;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=YERqA6ytYIBXeEnEVHuNkc6pRniKdplpfqUBYqgG5Qg=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpzoNsPXTXq4SVhzIheqeObqWYTQvIRMuziOMQi
 0C36f+/s9CJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCac6DbAAKCRAFnS7L/zaE
 w2pmD/440DWURcBlfLoxG1ut7dDL5r75R2Z2CNwXCwbe5iuVQdWSyQYU3GAqk7OJ6e/rskSlhXk
 d1bLbZl2YSIQwJu1dk6bRulANWGYCAq+rfmgbGrD7IIbPxOg+YMsXrSQnhJI+uaSdk5T2S5X1vm
 C8EJGN/IrBOhQy4U+RlX7jj/JbU/cUgItwbI+45LdR5NMwN46RLwplhhA5ZS1sZg8FUo2++rT/y
 bhbBU5IdlKANNsn1aHPftJ43l6cSnVWE4wXpo6yvljECtaxq0KsEGfH83hS5pmX1irMTkavuUXL
 bl00yb1QZAf0yyoO4oSQBuUZ33VyfSm5fUOQ5yk8+GcG/31SYObMjo/9WutCfX9cnR+sks8DdXt
 FhfwDGskJhGBrQ6Brb3ydCyBo5ld6LMWL+izYTIwEHZvMRqj79Eb6y4tWg1UkQRdY0t83RnDs+N
 l4FhjXw20/C0Kp6hqXtSuIQxgodaeja8WLAHkvm5COePsWSphIqjMTXnmmwpk7LFmhwKjIpC/zl
 m7DWI5uw0taCun+0/5GP3jp/bYYr4EJjDGZ3prKW36iHwCU/kcWLaSTG2zbt0femaNamOSCqUt0
 hSVhTkDGZJ9BOMLAmMSZicivMWfNdp4DO1Hn14ZDfb0uub0RkNWs02EUqZ+4hij6c+suz/BxuaI
 WFZXVzDVuX0pCWg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDEzNCBTYWx0ZWRfXwWDkiGAhGDPI
 Bqv+rw7hhH6QmnMRyRMovQE8ZBVTdLc9ErkSdMRaQOPF1rIGKTX9wTJsl4c5QAiO9RYMn/nXYt3
 TTSxX7UmHGN4OsCWO8BHIrd4FqUcyq7A80PMVkHWJ05WJ7dIauH3P0ru7riR8Px9xwWhB3woLZ8
 EKq/YzFxzdY/GSmclTdd19SN/S6LhgOc0QndeQO2NVmk/H5H9Fo6WHY0Rfs4J4PXYS1Uu6ytkub
 Fht6OKEKlfZRDmWjjRoES0avmvHLWTJCwC0VE17hBGQSD8Xt6JDpoNG7Lp8fGYBKbM1aasti0xg
 a0YXFHrJ0n5ppXC3sX+KFXNc0ATppapEDjHPrp6+w66ovB/HDvZQ1uAbENcy/Vzmx/0qFm07kOZ
 pVXiy0G1XDatWt6UE5/wCnUcsz40qMq/XxoLvBWcO093IuXs96Cp1bk8XM0XhRpAnpxkxojeAIi
 XBv08618XO32JZHTyFw==
X-Authority-Analysis: v=2.4 cv=PNICOPqC c=1 sm=1 tr=0 ts=69ce837d cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=u-biHsxzOdRIXVMzAPsA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 8fRjoR-IGPb1oU9HpewZsV620Scdpddl
X-Proofpoint-ORIG-GUID: 8fRjoR-IGPb1oU9HpewZsV620Scdpddl
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
	TAGGED_FROM(0.00)[bounces-9857-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,linaro.org:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
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
X-Rspamd-Queue-Id: 2928C38AF32
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

BH workqueues are a modern mechanism, aiming to replace legacy tasklets.
Let's convert the BAM DMA driver to using the high-priority variant of
the BH workqueue.

[Vinod: suggested using the BG workqueue instead of the regular one
running in process context]

Suggested-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/dma/qcom/bam_dma.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 19116295f8325767a0d97a7848077885b118241c..c8601bac555edf1bb4384fd39cb3449ec6e86334 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -42,6 +42,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
+#include <linux/workqueue.h>
 
 #include "../dmaengine.h"
 #include "../virt-dma.h"
@@ -397,8 +398,8 @@ struct bam_device {
 	struct clk *bamclk;
 	int irq;
 
-	/* dma start transaction tasklet */
-	struct tasklet_struct task;
+	/* dma start transaction workqueue */
+	struct work_struct work;
 };
 
 /**
@@ -863,7 +864,7 @@ static u32 process_channel_irqs(struct bam_device *bdev)
 			/*
 			 * if complete, process cookie. Otherwise
 			 * push back to front of desc_issued so that
-			 * it gets restarted by the tasklet
+			 * it gets restarted by the work queue.
 			 */
 			if (!async_desc->num_desc) {
 				vchan_cookie_complete(&async_desc->vd);
@@ -893,9 +894,9 @@ static irqreturn_t bam_dma_irq(int irq, void *data)
 
 	srcs |= process_channel_irqs(bdev);
 
-	/* kick off tasklet to start next dma transfer */
+	/* kick off the work queue to start next dma transfer */
 	if (srcs & P_IRQ)
-		tasklet_schedule(&bdev->task);
+		queue_work(system_bh_highpri_wq, &bdev->work);
 
 	ret = pm_runtime_get_sync(bdev->dev);
 	if (ret < 0)
@@ -1091,14 +1092,14 @@ static void bam_start_dma(struct bam_chan *bchan)
 }
 
 /**
- * dma_tasklet - DMA IRQ tasklet
- * @t: tasklet argument (bam controller structure)
+ * bam_dma_work() - DMA interrupt work queue callback
+ * @work: work queue struct embedded in the BAM controller device struct
  *
  * Sets up next DMA operation and then processes all completed transactions
  */
-static void dma_tasklet(struct tasklet_struct *t)
+static void bam_dma_work(struct work_struct *work)
 {
-	struct bam_device *bdev = from_tasklet(bdev, t, task);
+	struct bam_device *bdev = from_work(bdev, work, work);
 	struct bam_chan *bchan;
 	unsigned int i;
 
@@ -1111,14 +1112,13 @@ static void dma_tasklet(struct tasklet_struct *t)
 		if (!list_empty(&bchan->vc.desc_issued) && !IS_BUSY(bchan))
 			bam_start_dma(bchan);
 	}
-
 }
 
 /**
  * bam_issue_pending - starts pending transactions
  * @chan: dma channel
  *
- * Calls tasklet directly which in turn starts any pending transactions
+ * Calls work queue directly which in turn starts any pending transactions
  */
 static void bam_issue_pending(struct dma_chan *chan)
 {
@@ -1286,14 +1286,14 @@ static int bam_dma_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_disable_clk;
 
-	tasklet_setup(&bdev->task, dma_tasklet);
+	INIT_WORK(&bdev->work, bam_dma_work);
 
 	bdev->channels = devm_kcalloc(bdev->dev, bdev->num_channels,
 				sizeof(*bdev->channels), GFP_KERNEL);
 
 	if (!bdev->channels) {
 		ret = -ENOMEM;
-		goto err_tasklet_kill;
+		goto err_workqueue_cancel;
 	}
 
 	/* allocate and initialize channels */
@@ -1358,8 +1358,8 @@ static int bam_dma_probe(struct platform_device *pdev)
 err_bam_channel_exit:
 	for (i = 0; i < bdev->num_channels; i++)
 		tasklet_kill(&bdev->channels[i].vc.task);
-err_tasklet_kill:
-	tasklet_kill(&bdev->task);
+err_workqueue_cancel:
+	cancel_work_sync(&bdev->work);
 err_disable_clk:
 	clk_disable_unprepare(bdev->bamclk);
 
@@ -1393,7 +1393,7 @@ static void bam_dma_remove(struct platform_device *pdev)
 			    bdev->channels[i].fifo_phys);
 	}
 
-	tasklet_kill(&bdev->task);
+	cancel_work_sync(&bdev->work);
 
 	clk_disable_unprepare(bdev->bamclk);
 }

-- 
2.47.3


