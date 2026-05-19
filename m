Return-Path: <dmaengine+bounces-10542-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJg2E+VjDGpXggUAu9opvQ
	(envelope-from <dmaengine+bounces-10542-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 15:21:41 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5767C57F819
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 15:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9E3703038D62
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 13:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162B43ED3BF;
	Tue, 19 May 2026 13:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nUnR4W0z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HhXk+8F2"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B454C348C75
	for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 13:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779196707; cv=none; b=tAVVys8xv/t3cezr+Z9aTDCyNzBhYwXepm5UrpL2Bl3PBjRonT2qv/3kJKQam69/s8aWleD/i/CSwx47Cxy32Do+3svQfDUAHiSjquCP3M5b6QKSdGOAEOmsqKKrYh7kggVafXIJrsYb0WwfkTFzN/CjvIE5OD7dCoj+Ch5+euc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779196707; c=relaxed/simple;
	bh=5ItlPbuBhP65nUTpXCo9dRl8GJjRN3Zgl/exx3Ev5Lc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TzqIEsYnyms/NqeOHqIRqrqGnkjgtMkyWk4rOfTTO2bsFB5IaMpWReAMJmBcQ6J5reUEwS1D+J10Fx/RDf+Vdmy/AFbrwJmpqox14b9S6Ybq5YZvr3aHXGdhiYbSFqw2e/XcEED6lYHLKTUbqN+0MpJTCTjKx8C5IQQdYHllbwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nUnR4W0z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HhXk+8F2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JCV8YW1737108
	for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 13:18:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	25Y3YTCZIMOzZ+yX4mVdRMjdJrxXuFwJ3ZTHD7azqTY=; b=nUnR4W0zT4THAyDA
	BO5PEYk5i36DYPXVfbCQORPC2a1zrZ98GupBpJZPlAuucFGO1xwgnYBoENeGd23Z
	bJiXwvReW7Ka2T/bIJ3ci8V2vsf3a8Razr/6jV6H03Eupsz8ajwdjnIc6w3aW94E
	QEKoIyIoiTB+f20kRkx3cllmfRmPszNX0fuXnc5jKrts2VdJwHBn1RukFUZx2/h7
	lkmrnHKRSuUNvUTyCsFRJCu+8sjYBYr2jGXH0b1W4DqPPEvfWd/iMi9me9gOjy1j
	DRyX3uX99ztgFvqFhbnkjoYLE2T1DVZ0y+Kf1xicV9VtiRXTZsuOmfo+WsSfc2Uk
	KGeZng==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8ju91jkq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 13:18:23 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5756f9292c5so2864552e0c.0
        for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 06:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779196703; x=1779801503; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=25Y3YTCZIMOzZ+yX4mVdRMjdJrxXuFwJ3ZTHD7azqTY=;
        b=HhXk+8F2xI+OmpXuHWtB5Sp5e3gV7xjsbWL1sqodI5G2up5QPaQQ8uwUotw/vH35R+
         IDq9lqIs9eSCpQhMdyWWCN6qgr5cuX/g8p10MeBERDe6Kgt11q/WqQa5IRqTLRK/d/Ta
         yiTmuLa6nf17vKNZWGseI51JrYiPn7T4j2XMDVDc5IVrJy2QqvSwd+ppOY3Gnd8/k+Q/
         6dX4DGT6P3MAS0PQO7LnkUy9SKfrLbmObNDvO2EwCk2lIRlZM+G/mTYVqYfq/nmVz5qQ
         mqP5QfE76HLuEf0EykYmV3gin/160YDkdxLt2PskxxN89TKTxtz+bqoQKqE5bGpx2LsS
         E8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779196703; x=1779801503;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=25Y3YTCZIMOzZ+yX4mVdRMjdJrxXuFwJ3ZTHD7azqTY=;
        b=MUayvwhp1iWwUcP56u4/W/O2cnC3h8vK/tqAAmhDwCbYTkYpEiNqRWvpwzX6nG+3Zf
         dcEgEO5wsnDNaeJBvVQYoVOsNTOLszupAgNHmBpTBI7+im3L4jCBLGeTwx0Eajw35AJE
         yvMsgxHA3rKYVT6ZRZOuCHIZYZhBcIXnR6ztr9BTyQecw4SLSwmdr4E/+BQUcxZslmOx
         mkNrrDj27xJdfrYUDsiZxMvTlRakOfqaR1BuxIQi16C2yhuq35NVLJs9zrzNNkvNPbKK
         7JZxk6kkMh4PIB3c4vHnYB/AUKnPczQ/i2O8I/Re4eDiuh6C/SXUwpBorQYWndA7Pe/q
         7nrA==
X-Gm-Message-State: AOJu0Yyyvz0+d/ppB26hZPGwBsQTwP2qiiqvL8e+HBBqVoRm5SWYWwH6
	9SpS9otxP+rO+PAncN//xwVPsfSVkjBGMQbVmQM8fdrd8VaXMyiczMLiz/hoY7vff6/klbDomnC
	UFGaxR2TVuRCuH/Bu7pq1nX78rJlORuOOMqXj52ipRbNLHsB0D5uaKnzSjzVEBog=
X-Gm-Gg: Acq92OHZU1diTdIdffCCn5vGUX2vMFMauJZP3hEBwWdO0sWSnjIdiylpbqVOgEsdRiG
	9vkJgapr4HrZkO37R8FBkE8vHIcqSSOR5QOsK6iLj5FjmDVA2irqqpV4yPdhsKP33NRHHO5+QNY
	+SPReEZbO0cRUtq0nk0iQTiozbgZMDcYhk5fmOqbIyo3QdCLPYNhk/YzLX7WZz/YiMKOeJ8+Uf3
	Tr+Ia4RrNz4DWX9nEmdOEeYUs4+ZMkJVXdMWnkifCIJBAWoxRV2oSDUVIP1FLnUvMk866i6TfVv
	IV3ZjA1ItNEXjYVMAmAgTDUbzAPJa6nU1/Xme73F2UmFcQaFZ8qN5fs4unjEonjd+szhE2ZoQDp
	nrN5RlZ2gpTRG2frIbgTwF6gampGQWIKMFREvL+Z7toeVeFeXVKI=
X-Received: by 2002:a05:6122:e247:b0:56c:ce0b:fecd with SMTP id 71dfb90a1353d-5760c09441bmr9346569e0c.12.1779196703020;
        Tue, 19 May 2026 06:18:23 -0700 (PDT)
X-Received: by 2002:a05:6122:e247:b0:56c:ce0b:fecd with SMTP id 71dfb90a1353d-5760c09441bmr9346525e0c.12.1779196702531;
        Tue, 19 May 2026 06:18:22 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:3fb6:74e3:3c25:ba2f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe7dd22sm143969195e9.7.2026.05.19.06.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 06:18:21 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 19 May 2026 15:17:49 +0200
Subject: [PATCH v17 07/14] crypto: qce - Cancel work on device detach
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-qcom-qce-cmd-descr-v17-7-53a595414b79@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1394;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=5ItlPbuBhP65nUTpXCo9dRl8GJjRN3Zgl/exx3Ev5Lc=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqDGMI2QVh4QfndgsCdNJD5n4VcvO8wt8Q5d+K/
 ZH44cIVyrCJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCagxjCAAKCRAFnS7L/zaE
 w7SCD/4naK6qeLv2LqSaYlys+AC2IFPuiySUYpicSD14elbykLxS88aNE36/HjJDfx2KdgTGz2E
 6lDBGA02ogSf8A4sS02QdH39yDnTbC2VmgGbksHM7AysDFjO+oeKyayaE5ouP6zqjLUqYgD27Py
 x+c6BVd7KOsHWvLXGFWqBw3uz76d769SzY71UOkdLG349OLlqXANFldeuBs+YHoNao8cFvu4rCM
 4QOwsctgpNtl2mBSL2dP6TQasIBVn35viGQgC1JR6GuDo6nV/1gasDUumnZT6gy/dA/vPbcTkPq
 RtltJxBhOWYX51fF5oHbJDQ1HDHGyq4eMzKbEACEPx3JvJIvo1HJ3xhfa21JFKemU0EqhKW92pX
 ao2iuSFx84uqCIHUAjYBsg++6WdkxeMmnsqL15nxvFhm/esX+gC9zo32q7MhweFuE5LkAZlSdfz
 OSw8pLIsXi4SBvnU05aOt9TogVAKm/1LO+GSH4PNvyrWNjb7jpGpslYy/Y29bK/mls72DZY1HPo
 Ct+K2s9AFrKoX4hwE+SJDRt2ypAWlx4mkEwauNq4/8I4ikevdgQSvT6vXb259DAQMSjM/GAuVI+
 R1m68oimVXXb9U9tkbJC445i/80bOCPcc69OGI/4yc6wcjQwyQYz8JP9t5cQjraEqr1lIaMiS1C
 C5UV0W5yxOvAVBg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: flf1hz3bO58CvYk3YWIxtfPzAo_Ao2f5
X-Authority-Analysis: v=2.4 cv=eeUNubEH c=1 sm=1 tr=0 ts=6a0c6320 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=c92rfblmAAAA:8
 a=EUspDBNiAAAA:8 a=Jr3KVaxKR4ukTOMpvgYA:9 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDEzMSBTYWx0ZWRfX6k+ap0LkxaAg
 Pu/zfntTYngqrkLmTOM2DMW2uivK0+Nrx13Xj0NQfx3j1RChO2nG7N8v7x3nQv4NnYVlFIj9+7D
 4my8U1T2XntnxWVmxoVoZ86ixmd06beA2SXxYKIcFzJ/KT1FfN1ej14nYiqd+PznQTvz9R8n7hD
 pPHFC8q001YUCMeGAidLAjcB3J93UcYAZzVyh48ulstH9gYbotDqHFxp4MXfgEvSaR3j/nSigQ9
 qUKdyL0r3xteybn04eIDSxl+kuSp+wPTL7xjnoJGMJnn2tnIRhBaVms2MH1h2H8NwuNDsfeY4//
 khPBoliqBfemxBpZxeUUyJ+6UN0JNo11lWz+aDDjEumSOvwLE5EnKR11wdwCMBUjihEALoXAosr
 9/z0zdbV5Zr5cC20EnRyAxQhyEglIS3trYb0CE8tSztuNgekIvfbR4w6TLV4mINJTnuQ3OAmoUu
 6IBGWMHP/IefZA8aQJw==
X-Proofpoint-ORIG-GUID: flf1hz3bO58CvYk3YWIxtfPzAo_Ao2f5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
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
	TAGGED_FROM(0.00)[bounces-10542-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com,codeaurora.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,sashiko.dev:url];
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
X-Rspamd-Queue-Id: 5767C57F819
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The workqueue is setup in probe() but never cancelled on error or in
remove(). Set up a devres action to clean it up.

Fixes: eb7986e5e14d ("crypto: qce - convert tasklet to workqueue")
Closes: https://sashiko.dev/#/patchset/20260427-qcom-qce-cmd-descr-v16-0-945fd1cafbbc%40oss.qualcomm.com?part=7
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index b966f3365b7de8d2a8f6707397a34aa4facdc4ac..e82fc862c74b20c34ea5abd6c0b98b71089a3fee 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -186,6 +186,13 @@ static int qce_check_version(struct qce_device *qce)
 	return 0;
 }
 
+static void qce_cancel_work(void *data)
+{
+	struct work_struct *work = data;
+
+	cancel_work_sync(work);
+}
+
 static int qce_crypto_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -240,6 +247,11 @@ static int qce_crypto_probe(struct platform_device *pdev)
 		return ret;
 
 	INIT_WORK(&qce->done_work, qce_req_done_work);
+
+	ret = devm_add_action_or_reset(dev, qce_cancel_work, &qce->done_work);
+	if (ret)
+		return ret;
+
 	crypto_init_queue(&qce->queue, QCE_QUEUE_LENGTH);
 
 	qce->async_req_enqueue = qce_async_request_enqueue;

-- 
2.47.3


