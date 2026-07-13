Return-Path: <dmaengine+bounces-12377-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lYI6ANrhVGqKgQAAu9opvQ
	(envelope-from <dmaengine+bounces-12377-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 15:02:18 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CB87274B391
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 15:02:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=BPMW7qvk;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=JWcLO6W+;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12377-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-12377-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B9659301CD14
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 13:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21B1416CFF;
	Mon, 13 Jul 2026 13:01:36 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5966C414A31
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 13:01:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783947696; cv=none; b=fKxruXPgSEDxjCKYtx2Hm4/MM806ZrWnESJ4xpniwjTzA3UnMm4a1hZ18xcADDGneLYyOrMgtE+RFsJGhgF6YawwkVUr7mqUzIqb16/DL314RAd7U0H0bIRX/R4JoTZ6yI8YzRnD/8HDs1hAUVWmYyPDveanySi6IC5WjLOG5K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783947696; c=relaxed/simple;
	bh=4nbFs/xg8cCMPYrFtHWE96AOtkhXxC7yUgPXEapSLFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nhmwaLg/wYoqHsYQgjnuUJEWpnqHCUXgEWoXKpyAZmNtDNjSiWb/NB9/wU5X1jFiGk+b+DbQWPhlzhYRbQLIaZ6/Q9cPjBo/2sFF8rpnDhmDb56L3H5SQXc4YbPV4Zaq9ufkMy9Rc37fwxBgUeIfh1/6C7vJI9koCpauXKxm2JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BPMW7qvk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JWcLO6W+; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DCDwGm1428344
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 13:01:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/Vh6sT+8mC4wwsdE+AaqQfMuc9K2i5dAUjEpzQ2UVhY=; b=BPMW7qvk4rSt6hfp
	63NVF49Uug/1J+UqZRmu13NNmzyySLm+WIuCm8InPagd22orXm3WJQHbabsezl3t
	SgzsHsBJXP/0IuzYU4ChVZJVUMzZ0cDk64sZzQ26MzDO1zJ1govoSOLqDumCAVww
	qHFJ3EbQac2wbxux3joUkrpJCYNDFVP9UOUzhb4abwFOmBknvlfA3DpccDzPY7UJ
	2m6iWDMoHs6rBEXMZQuz1kfL0hIa4hNKxkCukX5Sd14MGIeI0rOgtSU+22xBvGbi
	OMMPGrWiJ+uCwVtrhMJFtMh5tq1WkgwY4jJQIYYewBeSjb6q3+x/HtPrbN7gcrwp
	KM59hQ==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcurn15jh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 13:01:32 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-6a37fb394f3so2283448eaf.0
        for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 06:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783947692; x=1784552492; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/Vh6sT+8mC4wwsdE+AaqQfMuc9K2i5dAUjEpzQ2UVhY=;
        b=JWcLO6W+5Qc6ie8sQXtgkO884bcTyYr8gZGdCpRZ0QUnPCpRgOFG6fuMAM4x+IYeMq
         CzSpE47uUEQdtdicB/AkDJ+bxDNcNmWDMGucYvMwwyvwkXpMRs0EaVt6R/0vwucQfOMT
         7ogxnnr/K27rnvsq3wRGknd5i0b6dq0AZF3CDzWXbzOou4Iavjyh0flL+jDnkOP36AA3
         zJAC8f4bkYFkUvsEBAextRE2GAxkFlYGYjW/xAkc3/qZtXN9IKO1NkpOPEnOlJpfSuTy
         OgKixHku8AukoLdAJSA3VcTI9nNYLZMwUDwObDku0rsjHY57ftkA6duJaO6Fa7HhlL5G
         ZtHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783947692; x=1784552492;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/Vh6sT+8mC4wwsdE+AaqQfMuc9K2i5dAUjEpzQ2UVhY=;
        b=qLualGOrMQWE5C3iTKMu6c76mOB85oRhhhciyJmP2qV8k/tPw3oQU2cN/TxvjuqTND
         q7F+qD7GjoNvBJiBMagofDdVlKx51UwoU4wwec+Nqk4T5SPdX1rQu6c9NiERaBPrcUzd
         EiScCt6to2bHVXOiWrNe7l22UHaXUNNTXZsREx23Zlznwlj/mcaFM8fKfz7PtmYNei5i
         EaIJGE9LHnhkFjeV4pU35+BzMhmiP4j0bs9AoBuzd597Yo6ZjxOvAWLRbV6sGwBDcGaD
         iN3uQmxKsA//2LG20rl6Dkmedn9SzRSI0ZC2jHcxUxAw1EM6uLhX7Nn2skl7NT3d6Cui
         uHfg==
X-Gm-Message-State: AOJu0Yy5jDXAP6/hAr/0qVAVJt1WzVnWTVtphidkgXponv4t2n23uf6Z
	wISRL4pLtyPxBKA+3tGNVKA1EmK1j1GoOLoTCgHhgZOripW0VL0ihx5HT5JFLBR7M54PBfUVo0F
	WJ2IP0CzWjI7gAYl1xzSKxjZy5+mXobV5RyIYpzQ8/L9FubrcThJx1TIAMWXTG+k=
X-Gm-Gg: AfdE7cnPQtjGQGEOfLzpd0tC2mSw61bxHF6xvYYDdGvrRLEjQ8VvhCgnib87AG/76ry
	iCJf6phzk1iUdpJ2KQ+BQZUa1gFmuJNQdXoqndyPbjQH2UWp0oYuPJWMQNKw6HAA3WmpxOQMZsB
	Nqgv0JqPp2l9DudHmupT2uKmAESNwHUvfILiPHOaZ6yGmjRd1rx+pflqyFO8HM3kL2oF2yoZm8b
	ghAEL9ymT6nF3adAfb+JAPSqB+jeECk40uZfYaUUkS5Y/EaMPfo+tx0+ODHW6XntwuWwo0RtO/y
	r0Wh6HwTCA1+ts6MLlEgKyxp0y/27sh/JIjuz+evGSTHjAqWSMJi2Y63OpncExMksNFsrYxpPFd
	E58rYBRfdESrHnHaSqAnSF56NXtF3Smu5SqpHOQOc
X-Received: by 2002:a05:6820:709a:20b0:6a1:87cb:c34e with SMTP id 006d021491bc7-6a39a8bc0cfmr3777044eaf.72.1783947692035;
        Mon, 13 Jul 2026 06:01:32 -0700 (PDT)
X-Received: by 2002:a05:6820:709a:20b0:6a1:87cb:c34e with SMTP id 006d021491bc7-6a39a8bc0cfmr3777006eaf.72.1783947691457;
        Mon, 13 Jul 2026 06:01:31 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8881:83b8:89fa:1a2a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f2d97527sm306129725e9.2.2026.07.13.06.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 06:01:30 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 15:01:03 +0200
Subject: [PATCH v21 02/14] dmaengine: qcom: bam_dma: free interrupt before
 the clock in error path
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-qcom-qce-cmd-descr-v21-2-bc2583e18475@oss.qualcomm.com>
References: <20260713-qcom-qce-cmd-descr-v21-0-bc2583e18475@oss.qualcomm.com>
In-Reply-To: <20260713-qcom-qce-cmd-descr-v21-0-bc2583e18475@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2818;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=4nbFs/xg8cCMPYrFtHWE96AOtkhXxC7yUgPXEapSLFc=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqVOGW93v0sClC2ft1uCv5Hw3EHtNtjlSJJwq2r
 tE4EdQeEpKJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCalThlgAKCRAFnS7L/zaE
 w/uzD/4w7eNiuNpdXOL3t9tZlS5LdaL8UOWb9G3C8AYDPtr+fAN90n14n2NZg3uMrzojjmDpFUt
 9Iksuw7xVCS8Q7h06Z+LOwUYoaNcF0Gc2xPMRwd195hnUU/A+s7yXeaIJBr5PUJj9SG+Tij0l0q
 4bMuNqytBjFwaz08h6FCxbDKCbL9Ff2GWef6txBaonkpWuyrvUvT3V3h9z/lk3gLr1W3KH2dT2j
 POs49V+Qbj1NxYMoJW2YDLOhagEbVsSydQW2ipiXh4EsYKumCfShgSwuZAD8YWz01K4wF4o86YB
 Sj+m4+o3hUIbfnqo9ftCfyMDopd1O6fuaTMGO3yLaxOv1SEcoQIGNBpgHsaKsaj82CESkHpYOq0
 4vzS/QnSmT/XNVCQ352PE2k5HJssuzCzUFiX21caaVJ9HegTqNjL+sO7XXyFHiHx+eyhevnboX6
 zLdH9SIZuysid7hmCa6D6JwQJfiaJgT6naeB6YZiXeiqNpnlF5YdKB08eFK4Xy4U/0FnI1GIfaU
 MTQvGK1+c4PQOI/98pLZIEKZj/V6+LWNqt4LwDjhTBeQ8HFC6p0P2RqQfqpw1MnErtYQAC3D+Zz
 TUMi/XvI79oxiLqk9uhZMCGkVrz/zuI1f/T24vQF52gXfwhD71tnxmULJ2aTCOV5TxdY2AcfMnv
 qYTuv6HHSU9AEKg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: CJuZ-BmA5JTYLie2XrkL8k9I9Cbclndg
X-Authority-Analysis: v=2.4 cv=IcK3n2qa c=1 sm=1 tr=0 ts=6a54e1ac cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=c92rfblmAAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=n8zAjjMAgf0wD31B80cA:9 a=QEXdDO2ut3YA:10
 a=WZGXeFmKUf7gPmL3hEjn:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEzNSBTYWx0ZWRfX/zWE54q4vMaT
 EpOI+VopzogoEuO/ygGwI0HiuNB2FIL2TbyzB/4Lo2i6PZPVfwYRvksLwMQ4a8Pqdkwav/cHZ3k
 10oekk63ceGXN01uXcvr3sGGC0kMTk8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEzNSBTYWx0ZWRfX+mQidW+VZwiI
 GWdzSgPkDla3oncerXgxjhQefLytPJq6WNrFl0vYIdLJV4fvMDoB+V9b+TkdcFL9Eaox3gVgeqY
 LrLbRyDxa6ffaVBXb4XrKOz+4fjdtJG3IZcRUdSgRzxxdjTRUGunIqXc492ytYsAHAGR5PzSvq7
 yBxdSwNOXYdmQHcpdesrFpxNUM0nbj/lOmQ/W3hYWOn9/qj9+Rs9JVYZeWlf9w69Fq/hkL9oE5b
 T4/FevuzZu2jMDYm07cz3DCV/NV9WHgkfY9z7eeUkoObK0jGeaGNVzjny3+qgt9+ONbav9gCZ9M
 qCcevKi604yMbzXzqGjATl/kJ1H5oEbMyDprRc+3Z4wpcwVASnxwkiKdhsH3126u93YiMdoBPI7
 supoOXxaqYWQMocdRBw9TDiYREzw12Umdgxv6cSnucnogzi1c/L2HY9yKAf2uoHLIcWFPq8CcaI
 wePQZ7kdPok7TBSmY5g==
X-Proofpoint-GUID: CJuZ-BmA5JTYLie2XrkL8k9I9Cbclndg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130135
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12377-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:corbet@lwn.net,m:thara.gopinath@gmail.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:quic_utiwari@quicinc.com,m:mdalam@qti.qualcomm.com,m:lumag@kernel.org,m:mani@kernel.org,m:stephan.gerhold@linaro.org,m:andersson@kernel.org,m:peter.ujfalusi@gmail.com,m:michal.simek@amd.com,m:Frank.Li@kernel.org,m:agross@codeaurora.org,m:neil.armstrong@linaro.org,m:dmaengine@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:brgl@kernel.org,m:bartosz.golaszewski@linaro.org,m:bartosz.golaszewski@oss.qualcomm.com,m:tharagopinath@gmail.com,m:peterujfalusi@gmail.com,s:lists@lfdr.de];
	RSPAMD_URIBL_FAIL(0.00)[oss.qualcomm.com:query timed out,sashiko.dev:query timed out];
	FORGED_SENDER(0.00)[bartosz.golaszewski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com,codeaurora.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sashiko.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,vger.kernel.org:from_smtp];
	RSPAMD_EMAILBL_FAIL(0.00)[bartosz.golaszewski@oss.qualcomm.com:query timed out,dmaengine@vger.kernel.org:query timed out,mani.kernel.org:query timed out,bartosz.golaszewski.oss.qualcomm.com:query timed out];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CB87274B391

The BAM interrupt is requested with a devres helper and so on error it's
freed after probe() returns. We disable the clock before freeing or
masking it so it may still fire and we may end up reading BAM registers
with clock disabled.

Stop using devres for interrupts as we free it in remove() manually
anyway. Add an appropriate label and free the interrupt before disabling
the clock in error path and in remove().

Fixes: e7c0fe2a5c84 ("dmaengine: add Qualcomm BAM dma driver")
Closes: https://sashiko.dev/#/patchset/20260427-qcom-qce-cmd-descr-v16-0-945fd1cafbbc%40oss.qualcomm.com?part=2
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/dma/qcom/bam_dma.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 1bb26af0405f3a16f97e0d4b86c945c252d97f57..fc155e0d1870cbb7e099a2c4280f9f8fbdf6cf15 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -1332,8 +1332,7 @@ static int bam_dma_probe(struct platform_device *pdev)
 	for (i = 0; i < bdev->num_channels; i++)
 		bam_channel_init(bdev, &bdev->channels[i], i);
 
-	ret = devm_request_irq(bdev->dev, bdev->irq, bam_dma_irq,
-			IRQF_TRIGGER_HIGH, "bam_dma", bdev);
+	ret = request_irq(bdev->irq, bam_dma_irq, IRQF_TRIGGER_HIGH, "bam_dma", bdev);
 	if (ret)
 		goto err_bam_channel_exit;
 
@@ -1366,7 +1365,7 @@ static int bam_dma_probe(struct platform_device *pdev)
 	ret = dma_async_device_register(&bdev->common);
 	if (ret) {
 		dev_err(bdev->dev, "failed to register dma async device\n");
-		goto err_bam_channel_exit;
+		goto err_free_irq;
 	}
 
 	ret = of_dma_controller_register(pdev->dev.of_node, bam_dma_xlate,
@@ -1385,6 +1384,8 @@ static int bam_dma_probe(struct platform_device *pdev)
 
 err_unregister_dma:
 	dma_async_device_unregister(&bdev->common);
+err_free_irq:
+	free_irq(bdev->irq, bdev);
 err_bam_channel_exit:
 	for (i = 0; i < bdev->num_channels; i++)
 		tasklet_kill(&bdev->channels[i].vc.task);
@@ -1401,6 +1402,8 @@ static void bam_dma_remove(struct platform_device *pdev)
 	struct bam_device *bdev = platform_get_drvdata(pdev);
 	u32 i;
 
+	free_irq(bdev->irq, bdev);
+
 	pm_runtime_force_suspend(&pdev->dev);
 
 	of_dma_controller_free(pdev->dev.of_node);
@@ -1409,8 +1412,6 @@ static void bam_dma_remove(struct platform_device *pdev)
 	/* mask all interrupts for this execution environment */
 	writel_relaxed(0, bam_addr(bdev, 0,  BAM_IRQ_SRCS_MSK_EE));
 
-	devm_free_irq(bdev->dev, bdev->irq, bdev);
-
 	for (i = 0; i < bdev->num_channels; i++) {
 		bam_dma_terminate_all(&bdev->channels[i].vc.chan);
 		tasklet_kill(&bdev->channels[i].vc.task);

-- 
2.47.3


