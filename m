Return-Path: <dmaengine+bounces-11846-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zvwLGBJEQmqI3AkAu9opvQ
	(envelope-from <dmaengine+bounces-11846-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 12:08:18 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCA96D8B0F
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 12:08:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=FpkTkdW9;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=iceY07Cl;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11846-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11846-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65ED530A5797
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 10:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580B83F8238;
	Mon, 29 Jun 2026 10:01:46 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FC93FC5A8
	for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 10:01:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782727306; cv=none; b=Z2Osi0wkIrMFINoDcOq9TlAkr698475JU3GtgibL6ToXnjglIwlQeGQ9dqwZLL7YJkKbKWg4hoUytGifiqMIgvOxUQRcCdMuV3j5HV4qUfX2YWbd6DxigOlOTXiLPT4tVtQGq+PT+l+ES8OHdNEQDS3BTyJOpOUmFR+jiV55rTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782727306; c=relaxed/simple;
	bh=k97Y8ImiDOSEM/i3DdCydkceZy4j+DJOA/cqgxZHohk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q/HTGb3hwDedtycwEDXbRR4iLfsvOT+PUg+uTo2TcPcm//VoaeZ+T9EfrkojBzYArqi8vVEbDn6PdmC13f7AhNRp6ERQAknbW3kYXtFbPlc81pQXRypI84sp9V2JWOvY8QF08/KG7pOMn2JomthZe4VnD0jcMB1zgif7tiQOagQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FpkTkdW9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iceY07Cl; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T9n56N2529369
	for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 10:01:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dak13vsaTB1dmsrIHeCt+zMpkHOZXt2RO0KMkS+FxIk=; b=FpkTkdW94q5lBN3g
	dkdN4jE77PcLbI4Qf53nV3+FAUoXtJE6R79k1lnsg0zWmc5sHC6uDAwk4ykMGyax
	pmCEmOKnHieLa+kvngcD9R2fRnAVSel6Q0y8bX/f1WsrWIgulXVJy6n0BSaNkD3/
	xPkFfwoj20VBVPdzgc6lSivn828PnQ73hvMncO6qjVO3gK+yhvaJcxfBDFAL2P5P
	vUCXPP+Txt2gzygMvb2UOw6pQL/jhC5RwJrZYqokcEKhvoAf4/o3WsU3qA3oDC7c
	9rQj1jMs1tfrgrJaLGqdKM9yokDBN5SU9oh/vpXOJUI50MovpOxOOq2rxJw/Zv7/
	qSWApw==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3pdkr1kq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 10:01:42 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-48f680bda84so5043948b6e.1
        for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 03:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782727302; x=1783332102; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dak13vsaTB1dmsrIHeCt+zMpkHOZXt2RO0KMkS+FxIk=;
        b=iceY07Cl7PrmGCI4bTmtK+RABzn4ECtETn1XaRUgjt1S2JgRVJBRyD823i2s35SRDk
         7c9W8yvUMRzN2Tpdd3PP/WLpKVIFg6vVN41zXteDMsqFxECCLSgO1K/cO9b9kKkYpuY+
         oS30zz3ZCpaCmPpFGWvbSPkJdwIdflBWfPqrSHLAbg30B8CfJRtrfJfeiC4Lf1SHpl0g
         jQabH87oJMfaT74PxULuvvHEU+3pk2KkVRkti3oeKDQqbdcJxdutfaQ0s/bECusuaNNG
         VkuepICRgVYZEHk1K52hjKftCrhUhNG42iRBzthsVtOdHZQW2n9XpQmeniwPdts4ONm4
         DvnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782727302; x=1783332102;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dak13vsaTB1dmsrIHeCt+zMpkHOZXt2RO0KMkS+FxIk=;
        b=nr/szizujiNEErBeMQp0Nt8JsBW2JY2dFHpGgdZhwBvPEbYwSA8DHGC9eC5zB+5wGt
         m3LxifWM136qr7WYJONO0ogeKMkcLG0zwQ3uSVDFcL2d0q8fkMq182ZTyWPMNlObwHrU
         QEVZzGj/dzoXklbVWSNPavIcHEkarkJN4/0UjyH+IMIpgiy7mYJ8QXZYP+ilt6YthBwg
         GFXbuZOOFWptQKjpllfO7+qpSf693aEVM9klUwNzRZsfs7L4CeRm1sJzr3d9mmHx4Wr+
         rq0xRCKLwha+j2Iheuew1urpFmGk1uFBzDjT0O6a+aoVfLqG9tD84Lu3LnnHxAkG3f/T
         9dfg==
X-Gm-Message-State: AOJu0YzZVieX/h9jA1LdXTLKVdgXG9eHmDs8NWhcENyEH5O4ySII5HjL
	cHJJ3d7rFnhMBpgAX9yhvp4mM2agBhGiUXd3YSFZqd1yvQwCEWJbkaCi74pVaDVOsCu/HyDVz8t
	SZrQ3l/QcsQBxYRMsLqAdjDzbpUBnY72JOZ+s9CjRqwbEMY4ZS7D8zk9nujfNgKY=
X-Gm-Gg: AfdE7cllB6Ln3qbxBybpeGAAxb8mW376kqBJGnq8PMxosw6h+1kiuRR2mptGJii4sKk
	SmfARL0WhQD78NtOndTk8s/T7yHfCEfoIHQFXuGbRcph4pU3LeR781lnhuJLKXoOEeIrHBtW8B1
	TSmiKIpsSR4hqqdBMgeK4/CNQ7eetiGh4DVEEJyPg6Agdpwpm7K42JkuEaOaZPix1BaXT0W9Sej
	6YKHIvnU4hXcunAyMTDSLk5oKx6rm/PvVlKTkX9QCFgCnJr13ZQ2C0fvXMib4mWAyy94dSRLLX6
	ZFmD3Pw6eC67prZx8Oktd8CIZfjqKEu99uVIWDo1NcAIcdwEZhz6ssmW3AGc2C5ZDzaPCsqdDJR
	K12x1b37TAdgnas7xDUBbo4rN4c2Q6umdDZrZfkKX
X-Received: by 2002:a05:6808:c2a8:b0:486:560d:aa8b with SMTP id 5614622812f47-49217721151mr14163614b6e.26.1782727302111;
        Mon, 29 Jun 2026 03:01:42 -0700 (PDT)
X-Received: by 2002:a05:6808:c2a8:b0:486:560d:aa8b with SMTP id 5614622812f47-49217721151mr14163591b6e.26.1782727301644;
        Mon, 29 Jun 2026 03:01:41 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4640:d76a:6126:9b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4705f8ea729sm24729405f8f.0.2026.06.29.03.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 03:01:40 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 12:01:09 +0200
Subject: [PATCH v20 07/14] crypto: qce - Cancel work on device detach
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-qcom-qce-cmd-descr-v20-7-56f67da84c05@oss.qualcomm.com>
References: <20260629-qcom-qce-cmd-descr-v20-0-56f67da84c05@oss.qualcomm.com>
In-Reply-To: <20260629-qcom-qce-cmd-descr-v20-0-56f67da84c05@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2473;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=k97Y8ImiDOSEM/i3DdCydkceZy4j+DJOA/cqgxZHohk=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqQkJu2j4B5iGt3lgZNmZCIOqxBYKHlpUlmdmNK
 obLr78GakmJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakJCbgAKCRAFnS7L/zaE
 w879D/wIIjeWzgU6Mgj8NFmmou09FD8ZwLrlnpBMuNQ6T93B9MmEWJzLggmXvFhz0tK79qStVi7
 RlFA1/40f9ZOVCiE4h5hJTh/8nVw5M1LhbO/ExjeCCtYg1IMpaVWawKSCQX+SuL5b8bqn2A7ZOL
 /fADVqxxeaHHQMnfAE2QYylq7jrwZqoeKnnIEsjJrbn3mvSj7vZrYKX1qLySAQSSvBgycHbVyVC
 jiLWDuToa6BMjh1zxM7/JKiEL+1pWA/EPLbPeiTtQGv6dHAEjov+aZFsldpbMyhM+c4HAZi8yeg
 yebcr1xdDCo2ybpZHTCm30+H2vRIgxJ3lp2/wXk0JCBBel++LtHIJnIZwPqCGa65BCAQC97SvOy
 txKcOpBdCc42/+MaF6qKbiTHoThSsNRRePD91nWsukHoi+NknUEbCJIW5Xmsnyd4otJwucURvW1
 umW9ZwlW6fm1cmhOiqXOeqZ005MhbIlulCbWFYW+dO8m8Fk6KroqlsrNm60g3CfOxNkcJqdCCpN
 P9AIBooZmPNVl8+D3tJLbkKQyxQI8zlwmP1g8sO89KmtQ1j8NPJ9fflrN6ZEeNQYvg6iSK3XD7V
 ldjRIfvRjQrMootA/aeUjlzwf2unZp7y4cLvtO4rQ8M6x8f8JQFfk+Zh6XZ2ayoxqePAMWGWGBJ
 l8GySfJl5GhypWQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=R8Uz39RX c=1 sm=1 tr=0 ts=6a424286 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=c92rfblmAAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=SDQHpg0AWQOuS8LWovAA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=QEXdDO2ut3YA:10 a=efpaJB4zofY2dbm2aIRb:22
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: Qsn5JMx--tetYm9tUSxX4hnac2b2qAS5
X-Proofpoint-ORIG-GUID: Qsn5JMx--tetYm9tUSxX4hnac2b2qAS5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA4MCBTYWx0ZWRfX74SnD5B64RFa
 45yMgY2BJiUCrLCK1fd4FyXLPvX7xNLjZZ5hoovH69Ry5QhLdpiOde+oi/2h1zRMBPJf0Ma8Hdd
 wDN3Pfy0HRfTmaXsfAtQODJr7V9ir6QxQLxIjlJnHACoYpAWmO51MXsdJU7gr80iph7SBm/kTy/
 8YBeKK6k2Ue5CkkqClL+HnXNFi+oqVuFd8nBre6o8r1tzJH1rhZwfLAP3eaAFECzhXyj6QsAk/s
 ByGPEeu8fzsnTTbyY3BMiOFxEjV9GPy0aDA576Q1SxMCTbA7fJWEN1kB3+02BJz3aXIBcCDqu8M
 bIpSJsk7lKcOluRw+ByspRDORRYBPtbEpeHTXSve65zRT+i0s7a1VrCxNQuCSr56+VkRu3FO1Fw
 rO3Go4pfKYLri0IbLp3P1S1nLHQyfUHOPuvTGQ/nnLtsJ6JHWjwZ3WNCE5YJxI4iyC8AIqF+j/b
 lu4aREIa/M3wY6q0f1A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA4MCBTYWx0ZWRfX0kmD+ZOt3+Wz
 QD+ibcVbUrSPW7HkN3dl95Qrxx/zC90Yc+umSPpXd4yA0vw63X3CjAKdT23wxXmz/Esg7ri0LSW
 TJSSHTUr8Es58+r2qkv9QxmSGUsv5Ko=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290080
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11846-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com,codeaurora.org];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:corbet@lwn.net,m:thara.gopinath@gmail.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:quic_utiwari@quicinc.com,m:mdalam@qti.qualcomm.com,m:lumag@kernel.org,m:mani@kernel.org,m:stephan.gerhold@linaro.org,m:andersson@kernel.org,m:peter.ujfalusi@gmail.com,m:michal.simek@amd.com,m:Frank.Li@kernel.org,m:agross@codeaurora.org,m:neil.armstrong@linaro.org,m:dmaengine@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:brgl@kernel.org,m:bartosz.golaszewski@linaro.org,m:bartosz.golaszewski@oss.qualcomm.com,m:tharagopinath@gmail.com,m:peterujfalusi@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bartosz.golaszewski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,qualcomm.com:email,vger.kernel.org:from_smtp];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ADCA96D8B0F

The workqueue is setup in probe() but never cancelled on error or in
remove(). Set up a devres action to clean it up. We need to move the
initialization earlier as we don't want to cancel the work before any
outstanding DMA transfer is terminated. Make sure we do terminate all
transfers in qce_dma_release() devres action.

Fixes: eb7986e5e14d ("crypto: qce - convert tasklet to workqueue")
Closes: https://sashiko.dev/#/patchset/20260427-qcom-qce-cmd-descr-v16-0-945fd1cafbbc%40oss.qualcomm.com?part=7
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/core.c | 13 ++++++++++++-
 drivers/crypto/qce/dma.c  |  2 ++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index b966f3365b7de8d2a8f6707397a34aa4facdc4ac..f671946cf7351cd5f0c319909bafd87e3af701c7 100644
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
@@ -227,6 +234,11 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	INIT_WORK(&qce->done_work, qce_req_done_work);
+	ret = devm_add_action_or_reset(dev, qce_cancel_work, &qce->done_work);
+	if (ret)
+		return ret;
+
 	ret = devm_qce_dma_request(qce->dev, &qce->dma);
 	if (ret)
 		return ret;
@@ -239,7 +251,6 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	INIT_WORK(&qce->done_work, qce_req_done_work);
 	crypto_init_queue(&qce->queue, QCE_QUEUE_LENGTH);
 
 	qce->async_req_enqueue = qce_async_request_enqueue;
diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
index 68cafd4741ad3d91906d39e817fc7873b028d498..7ec9d72fd690fb17e03ade7efe3cc522fb47e1ac 100644
--- a/drivers/crypto/qce/dma.c
+++ b/drivers/crypto/qce/dma.c
@@ -13,6 +13,8 @@ static void qce_dma_release(void *data)
 {
 	struct qce_dma_data *dma = data;
 
+	dmaengine_terminate_sync(dma->txchan);
+	dmaengine_terminate_sync(dma->rxchan);
 	dma_release_channel(dma->txchan);
 	dma_release_channel(dma->rxchan);
 	kfree(dma->result_buf);

-- 
2.47.3


