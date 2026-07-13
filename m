Return-Path: <dmaengine+bounces-12380-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VuUVHMHiVGrMgQAAu9opvQ
	(envelope-from <dmaengine+bounces-12380-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 15:06:09 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C987E74B43E
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 15:06:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=TR2Vbwha;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=A9GUALVD;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12380-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12380-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 59AB1304F8A3
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 13:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAE7413259;
	Mon, 13 Jul 2026 13:01:45 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7124189DF
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 13:01:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783947705; cv=none; b=npgvVtNau0xUK110Eix42+zi1jYrD8HQKYTDafcw8yOLs2gPwK2p4KYdV9LfIN4bN3zv7s+0EGHSayctx9aJngZeCq/x+PsEQRigPmtFnTMAsuwjfzu6W3FY8N/rEfme944Yl2bkUeTEcOivdSqQn8ARmlSbARW5zjCu0WeAmjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783947705; c=relaxed/simple;
	bh=1Q+aPsoEc8W4PfEahFbzsFEdkzT9tiwxUCi1Nvr+Dts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fSv6T8jCbZLFFgMraFKwg29GAaqisIpbxOrG1gENkYns7R6VU17LVjEhHCs0Y/DNr1h+aHT6tCjRIulDLRSLVpAHGPBV1v9c5lIcJWzcWaepgmtKZGEgc8Oie6tjdwEo3L9sr840S6Vd3gVmMFp+nCH/cxGCRQ2ldN/3yM4KlHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TR2Vbwha; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A9GUALVD; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DCDeYc1299388
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 13:01:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1SQ6fBG0Ah0G+Ee6NE98a2a6c+tVDqglySr17bUd1/A=; b=TR2VbwhaedtgsCjR
	Uc6c5F5h++logsbZPYpfV1Fh6PqmawOGcAHQ21iHQezcNdSzQJ/hH4I9NZYrOkqx
	lBLDY34/a6Mqh6J6TYfYnm5Nen5aVfGZURd12dK593ddK0mfSA0h7bDASCFnmosu
	wgZnL8grKitKP5SZYSqwqoJq8K1729eyWuqBzxz3jVAFEXnre0TkWWTyR7m0pTWY
	U5EtcCXUPZXtNmHR2JrUEIvV2wQBvJhkXrdhe5IGPrWD+zqHXj6+Q6M03pA53uqJ
	3PHoHBl9zJgx7ynl8BYeN2NrfjpBZ7+Ix7q+5uw/mgvMSLX2Pd0pIcgpdduXTkbB
	CBTx3Q==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwk3gq1c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 13:01:41 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7e9fa2cd5c9so4547286a34.2
        for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 06:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783947700; x=1784552500; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1SQ6fBG0Ah0G+Ee6NE98a2a6c+tVDqglySr17bUd1/A=;
        b=A9GUALVD5VLLOrf//+OFU/zWsZRjaC3X4F0U9k88YsUePzJ2E5A68IwDqWOgETAvQP
         p30qtfVKmm3CI5ZxgV56jflPYHhYfxNuwsqgh0faiRG/Z8xUs4BZj0XtKqSRTPX5YM3y
         T4QJfQreUk9nmfWbhheTgS1pwDD+TeNeWGskn2jMaBM2YbINR7SFpJ+KdwpPHqbXj6Vh
         8lAgOHyR+z0ssqTjBdQelJUbZEzB67vJ95VtogcQFsXxMNH03t4Le3UD/32b7vfO+dL6
         q+MNwkQ4P5VaTaOwFCW7wG8ZU3al2xU0P3DwmJHa2n4NrWwkag1Cp6DQR3Dyza/IpGkR
         hULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783947700; x=1784552500;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1SQ6fBG0Ah0G+Ee6NE98a2a6c+tVDqglySr17bUd1/A=;
        b=GEOyQe/somCbmjTK6VKyPzqy5u1b9J0H3NP9DnpdSiKtOC8t0oq9JC2EN/ibZPq58P
         B7CzRL7ElWJ007NPiBXShSn7UTTvVyYCSSB1IrT+H+zzGgA2magpgFs8p8hTOl1QJhFB
         f9glXWeDFvnRoydCueBEOE1y3mSrS6vdhcty9uSOHHC5gu2z0SEtfMz3pC9+eyfOFJLW
         zSye1c0Y1vNuP0QVUV8LNJUmg4NaDKd6q54hFq6s6BE8vlhSUxcN1A+ayOb14wbqW2Jl
         EmqS0ejokKiHWDzNMUvVSJo8j1NoNGGQyyvlejzkwUTTCfITOD4EA4O6Jou/n/t4nXRw
         9Y1Q==
X-Gm-Message-State: AOJu0YyZJx72s1morWGB1xekjVg5HhBrxubyuEdnZuNuu3RPk+5JdXOQ
	c0J6tA5iUx/48jJ15W7vhsaKHObOVxXHOffhXCAxrV1+5+YOGQ8HENSqLwOTn69nCrp3D+73lfy
	iIZA4SvGc2tsI/kyB4CSbSh87hLbF6JGUi71+lBggcDHJTTmO+HdCSLP3oAlb5gc=
X-Gm-Gg: AfdE7clXHqQeae2MdQRiVTtjRq4db2H2PUFhhRs1orG1UWHCjjc+6VKM6AGUMPb98l1
	fhM7XBp573VBCxzgN7N2VnNaomyFDMh4Crz1de2Q4FmoSiZMnBTeUwVevM7j0OSwlnZPdaiMxie
	WTcrUC3H30xTsS65Rfq+pfA/RaWv6zxn0dNvyE+BqqTq0RP+ATbJyV1RMoQlOlct35lLmgI5Pq1
	7GdQ4ZQ2c7iDmRmyhXjiUPMD+ySLy7kU/TQjkDlP7YCnNhKaldZ4GzYIXcR1gCMHnNf/4j34xod
	mqCTjnmqSxLzU56TZYBCm2URI2cbPB1tJwZf1mHxhlaDufOEauIjEAhE9VwKM4OzVx6iPvvw/Uz
	myqB4e3Ru7zvS8LS+cAB7TkWFeG951mXJOGTuNl02
X-Received: by 2002:a05:6820:150f:b0:6a3:74c8:c055 with SMTP id 006d021491bc7-6a39a561d8dmr5636260eaf.11.1783947700359;
        Mon, 13 Jul 2026 06:01:40 -0700 (PDT)
X-Received: by 2002:a05:6820:150f:b0:6a3:74c8:c055 with SMTP id 006d021491bc7-6a39a561d8dmr5636138eaf.11.1783947699138;
        Mon, 13 Jul 2026 06:01:39 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8881:83b8:89fa:1a2a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f2d97527sm306129725e9.2.2026.07.13.06.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 06:01:36 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 15:01:05 +0200
Subject: [PATCH v21 04/14] dmaengine: qcom: bam_dma: Extend the driver's
 device match data
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-qcom-qce-cmd-descr-v21-4-bc2583e18475@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4322;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=HGeQqzQf8+DrUa/4bzOvLohFWS/bDVC1MPHUwVaBFAE=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqVOGZvuGUYeChHOLC77HMfiNMIfVnN8AjQan6W
 BeS6asnms6JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCalThmQAKCRAFnS7L/zaE
 wy1iEACsz3YnAAnaz1k8qigqPCxgYXXpAPo28WK2BGkIxJnWSpkVg114GyWtZa9CVovWwDf2FNY
 5mPXTCu7d/cHhSoqNb2s+vD7NcQBdho/HyhKnh1tIToo54h1FbJ4ViWRQ+R8mflfyoCsz4yobXI
 XgbZFKJdPqtW+e0hYpbBF8nPlzP53vpRNpTu6kM4o3fdPUOtwL+sf4NpDz4J6gHcfxIPdStSGDP
 LF7rY6vs/mxVwPHuxytui86zaLzSz5BxthuE0QUgb9vqkibyJRvqUZpfONM1ZI4FQlN7gZcoaSb
 6RMHbvWs1VNxS27/r/4LwU3hHF3RjudDc55Bj2skAEillw4YHRxBHIXhhTy5KsS/wjO1MoBmhx5
 ttgqK7vp48MohSGVdH4GESxroODaknQWBMuIfeGmqxY9ymjvlPqdnCSxW/K3I2HmefMPPS8hSMe
 1CZIgnVz60PtsyVz55b5kqyE3RIpcDqN6Rn+Rg7jDAiH745nA2r9f8ESiwNJR82qMwwvqiLnjIu
 /dPR4SMJKOqA2wafaxWf4kJLmYWCoawsh8EXqmQ30Rnkv9NVk/6Bk6snCJ4jVo+YpJPEFCotVH/
 Ba80v9XTVKr3TKqVnlD3N/vpR3tp6SRRbPLqjndYlcmwY+P1qCQvBdLJBTR5TiIxFCvS0n6nT3E
 Y1DpNNcWZr2QC2g==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: W0UY_Lo4SFif_1VvMFvOvTezxiLuRJhP
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEzNSBTYWx0ZWRfX0a0Ev04wUIQY
 2xbPQK9RxcbY85HrKswXt63C0DJkCbuS9aPXDTbRk1fTrlFwHnNUjryN3XKcIUL6XsxkfFSDPEZ
 KoVyvCF1D9egIaJ6MEDPYOxyC1SZ8l4=
X-Authority-Analysis: v=2.4 cv=e6c2j6p/ c=1 sm=1 tr=0 ts=6a54e1b5 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=KKAkSRfTAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ioP1PY9e4_dTeLeN8ycA:9 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEzNSBTYWx0ZWRfXy0qY5lzt5ETS
 dY3wPcO1ZlR9GwG2jQKclpE/nuGz8b16puQRhDX/FDIifcQd2sciU08bEXSM07BMmO8nbMtd7fM
 db84uxYmGHzLdRRdPV2z22gap2JwozlAgiP0UM//CX6rHbreEryIw7Fc/DEA7isB0yjn2saj4lU
 PdFNak8jPYxmeEZvtuRT4Vx+zUGfSBMpyniONzedbgsJcPLIyBSPuMiY9EJVj4z5zgInuDq2fx5
 wByO3phssxU/83tyS/SXSp04IUsVnT2FRpDJ6scm1/4Bm0J1ROM0Td3Ia+/LLP/hEgM3+kpYevE
 6Cdpu5KQmfCu4cB+alwXHzrXvXOcJgLvD7pfcA6pW7y9Kude8pzlPWLbXTOs/PTeNtUF+U+u50r
 ASZ8MUTfzzllYB9HrQXEWZJPiI3nbpTtk/Ep7A8GlFYuC7ZQtMuwAbOjiWSYk0DBk2n0Or/o3Ye
 dtEVeReqM63Eq/OEQzA==
X-Proofpoint-GUID: W0UY_Lo4SFif_1VvMFvOvTezxiLuRJhP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 phishscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130135
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-12380-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com,codeaurora.org];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:corbet@lwn.net,m:thara.gopinath@gmail.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:quic_utiwari@quicinc.com,m:mdalam@qti.qualcomm.com,m:lumag@kernel.org,m:mani@kernel.org,m:stephan.gerhold@linaro.org,m:andersson@kernel.org,m:peter.ujfalusi@gmail.com,m:michal.simek@amd.com,m:Frank.Li@kernel.org,m:agross@codeaurora.org,m:neil.armstrong@linaro.org,m:dmaengine@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:brgl@kernel.org,m:bartosz.golaszewski@linaro.org,m:bartosz.golaszewski@oss.qualcomm.com,m:tharagopinath@gmail.com,m:peterujfalusi@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bartosz.golaszewski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,linaro.org:email,qualcomm.com:email,qualcomm.com:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: C987E74B43E

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
 drivers/dma/qcom/bam_dma.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index ea3df28e777f99c0532761b6aee6807ab23ab4ca..8ce0fe085c5fea6cc614edd692b5cfd264b94d5a 100644
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
 static const struct reg_offset_data bam_v2_0_reg_info[] = {
 	[BAM_CTRL]		= { 0x0000, 0x00, 0x00, 0x00 },
 	[BAM_REVISION]		= { 0x1000, 0x00, 0x00, 0x00 },
@@ -229,6 +245,10 @@ static const struct reg_offset_data bam_v2_0_reg_info[] = {
 	[BAM_P_FIFO_SIZES]	= { 0xC820, 0x00, 0x1000, 0x00 },
 };
 
+static const struct bam_device_data bam_v2_0_data = {
+	.reg_info = bam_v2_0_reg_info,
+};
+
 /* BAM CTRL */
 #define BAM_SW_RST			BIT(0)
 #define BAM_EN				BIT(1)
@@ -422,7 +442,7 @@ struct bam_device {
 	bool powered_remotely;
 	u32 active_channels;
 
-	const struct reg_offset_data *layout;
+	const struct bam_device_data *dev_data;
 
 	struct clk *bamclk;
 	int irq;
@@ -440,7 +460,7 @@ struct bam_device {
 static inline void __iomem *bam_addr(struct bam_device *bdev, u32 pipe,
 		enum bam_reg reg)
 {
-	const struct reg_offset_data r = bdev->layout[reg];
+	const struct reg_offset_data r = bdev->dev_data->reg_info[reg];
 
 	return bdev->regs + r.base_offset +
 		r.pipe_mult * pipe +
@@ -1234,10 +1254,10 @@ static void bam_channel_init(struct bam_device *bdev, struct bam_chan *bchan,
 }
 
 static const struct of_device_id bam_of_match[] = {
-	{ .compatible = "qcom,bam-v1.3.0", .data = &bam_v1_3_reg_info },
-	{ .compatible = "qcom,bam-v1.4.0", .data = &bam_v1_4_reg_info },
-	{ .compatible = "qcom,bam-v1.7.0", .data = &bam_v1_7_reg_info },
-	{ .compatible = "qcom,bam-v2.0.0", .data = &bam_v2_0_reg_info },
+	{ .compatible = "qcom,bam-v1.3.0", .data = &bam_v1_3_data },
+	{ .compatible = "qcom,bam-v1.4.0", .data = &bam_v1_4_data },
+	{ .compatible = "qcom,bam-v1.7.0", .data = &bam_v1_7_data },
+	{ .compatible = "qcom,bam-v2.0.0", .data = &bam_v2_0_data },
 	{}
 };
 
@@ -1261,7 +1281,7 @@ static int bam_dma_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	bdev->layout = match->data;
+	bdev->dev_data = match->data;
 
 	bdev->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(bdev->regs))

-- 
2.47.3


