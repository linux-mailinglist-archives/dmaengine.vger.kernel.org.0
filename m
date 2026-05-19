Return-Path: <dmaengine+bounces-10546-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0H1nMfpjDGpXggUAu9opvQ
	(envelope-from <dmaengine+bounces-10546-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 15:22:02 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E8157F841
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 15:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0724C304DD80
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 13:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA10B4028F4;
	Tue, 19 May 2026 13:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MuNNPpeS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ind2SGDR"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF684028EB
	for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 13:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779196716; cv=none; b=gpd99wMOTNefoM9f5BXT30S4N+j4WjdHdw3eJFGRP9jomxfEwBOqWM3MBNK8eDb7khvpoen65AmmthY28q89VlqsoWGnrTFZdpbwwlty4tQ9+Mwrw+pHwEFwwv6j/5WLf2aOf8JgKTRD6ibn05eMfuhYdyCRONKs9FNHHDGM1wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779196716; c=relaxed/simple;
	bh=9uIzNvyfvjB7Lfk2BX/bVvJu1lFsXDUaVj1eiyJyLZE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ROn+GF7avAOYoVdmhvqVS/UTryv/iSOAMcGl3v6lp4Ol28XPslX8Z9yWikCyhHFaC876ptFsaT/RBroVEvJW0Bx/ujg0hdiXuL41ZB8ai2v3yPA/eKAGXRhWnCQKZinosW6PQLnnZERhZiulUbpRh4Cm7fjPhn3Tk0BEmBZoIOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MuNNPpeS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ind2SGDR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JCTJs71737169
	for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 13:18:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rUFRedyxv2ZWJh5/udxxljoSXdv1UlG0qZX9Fs/V80o=; b=MuNNPpeSGs2mmyOE
	81M7YgB8TXY1c8g2eOoiNqKrUIikddT3MhnsM7bxqdWjcB3mVWgIhaGbnjtvt6kw
	ugWAK9iZlmaV3iWekg8o5s/Ui3K0CnW0ec5zrrHKHZHb53eLBBu0zQoxKjzcM5Sn
	5xvusjrvTqAw/m5T758jrUjgwGQlxelP0UosZHQD2xe5LTLYzPxsESaU2F2836fV
	DStVRcwUgTvjM93YXd7dCeEtMe1tnEs91t9jNAksxoeJEmhgRt4X6wNqryPnFgeJ
	ygDT15NlIvtzobgyfvWaY7+tr7XhbE+qZutF2bsTCU/eu39OepfAlmsyn9FbGRBL
	cf/XuQ==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8ju91jms-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 13:18:32 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5756024c77eso7901055e0c.2
        for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 06:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779196712; x=1779801512; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rUFRedyxv2ZWJh5/udxxljoSXdv1UlG0qZX9Fs/V80o=;
        b=ind2SGDRVfdK7KA5HJDohhwlOXs004fO/gv+21/fzcprNbU0J/6sA/fZ4TjzULst++
         7Uk0/y5Nl7Vn628V6jLjHDxt36BO+IIkcGIsFg/k8HFt3qSefr8RAdpQP4rIYiTR6vq/
         9CCPZuOz59OGPpCgridMNJWKg0kVenvIXKf1pqWBcb40uCbwS89rQ+3U7IJx0wAsg9UC
         4loJp9JVy2e+ByM5ornJbq8trMONn5/nGTFeZhkeDdTSMJXCswcxlX5Hp32fZ+2pxYDG
         JDaEmo8g2gwnpU9NMDhSfn6aIEw245s8ZHCOMgR3N5KCKdZujfnC4tUJb7KnSCAGV+FX
         rxBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779196712; x=1779801512;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rUFRedyxv2ZWJh5/udxxljoSXdv1UlG0qZX9Fs/V80o=;
        b=jjbpdMfr4+Qca2742uXxVUmrSjhuhBubrAK9KarTXhRNWGVd/Qkge9OwVARwnTs3tS
         UfzCDG08jrgRCcwCEnti9HIVzlHJhniT7ttX3syoQ9aPTDqU1adUXgs4GUBBwf721yX5
         SccP/6Vfd2xE7HLB9/SXmghW4g45k68efQkxmse/nXSbJVDYN+mlegoaccVg2L7dvX7f
         kjb4964W2FeWuELDYhpGjXWzQVc7rFJXgn2lREpLRdpO4+XmGuEErylCESHiY9Rl2x7N
         pGF2+P9yWHHhTvUfnhlyPIlyfszLdCuNDvv/3dKVlPis3d17m50w/ibqMR2LI6jT21Y7
         mVYw==
X-Gm-Message-State: AOJu0YwvyW70iK4O80IGJ73Ay7466VZJhv2dxZ7nbjClpAx6/HYyr08u
	cVhIclkJG6cU1V8Zzt5gWMhVxgKtVw1oFY2Jwqtl+y2S0SzrXxiVmIuioAWXn1EfQOXHzSKU6JZ
	BJ1uEKEIS405a1KlrvohjF7c+AUwNFOGkkkFtvafoYrbjmpGXRstOx508VMyVQXk=
X-Gm-Gg: Acq92OHls3pIYQ4ZYa2598KIwUkk8Od3OTp5YT4jZaNZYFCzHDm7phpKd70wpdrgW31
	U89dgxOZOCm/Cs/IkweBtZFA0nMvM+7XhxxGzf3H9PpC7LgA7vLNG+IB7qAXHLK9cKglCV8Wf1J
	BPz6m7cQbRPibV+vc0w5t8CBMeWlLDguiNspSxkvHA3sTK7coqWpt2W5DoBkUqE065P5XUEXVZm
	hL3YR2+wapPY+JyubvqbADL3EJWa6d4JgkT6au7HuiQTT+rGhd52NiT0eKsjzrIzbjIIPq50J1K
	cvANqUnviZBq5mi0Pb9DjNAtW3Woksc7lNZPouFphXDwatpcECv002LhBd2916vgjR13RGATddV
	eIzBhNexki1FgFxvxxp3fFgkAZbSM6iZsJzdOcrDmTb/y00egjLg=
X-Received: by 2002:a05:6122:338f:b0:56d:31e1:2c9c with SMTP id 71dfb90a1353d-5760be39b65mr11841953e0c.3.1779196711776;
        Tue, 19 May 2026 06:18:31 -0700 (PDT)
X-Received: by 2002:a05:6122:338f:b0:56d:31e1:2c9c with SMTP id 71dfb90a1353d-5760be39b65mr11841884e0c.3.1779196711297;
        Tue, 19 May 2026 06:18:31 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:3fb6:74e3:3c25:ba2f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe7dd22sm143969195e9.7.2026.05.19.06.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 06:18:30 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 19 May 2026 15:17:53 +0200
Subject: [PATCH v17 11/14] crypto: qce - Use existing devres APIs in
 devm_qce_dma_request()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-qcom-qce-cmd-descr-v17-11-53a595414b79@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2326;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=Kub9ORcm7+PjuGNnZqvGfNQgLhDmAjRY+udGQlXYRFY=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqDGMLWsN4P+y0sI6nEo3BmIFA8t/ghg/wXe5qA
 Ql+ONm/pqyJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCagxjCwAKCRAFnS7L/zaE
 w+krD/9XHniBTHaTTIndeLMo76y+ouTTwRewnyUZAauiPo9reRkjMHBltEt6SiBr3iFPGpXAd/6
 L5gstUto+856tZiKAd1qNe5g9kXSm3lHbgb6xadcJWt8F8zuUgjnW/4VbXV7Ix+2zOHWIyvWYaM
 TkGjKDGFRV2Sf2t9XJ0PbYI9yHZH5RAwmHSP2iuza3+1OddN5CbKu6+DPNJs2ZOmXFFvexdbUZm
 p0Q6CxK/HpRDO+NbqOiM0zbEsrySJ6l0QpNUN53D/0jPiCAsZFNJ8SJTmhUhWhKsEsPFdwG2OCo
 wHaKp6PACef7O6n0awDeHXX4JGrv6wL+1SyAMIN0JNPbim1hmscQFqjQncKd3mP89sb61pMLRAj
 NsUbg1jOdeilx3GPB+WM9z+Jp2gGEQBsDqQg2uHL+OjnvqecGyNTgx4iICm8XGSEcJ42Xbbotvh
 oqanh3S9oO/3tFeNad0mNGjeW9yXc9+ZykbexBzgVU5vCrqRbiJ7hd8Sghs80HnopNR0d8/ANsP
 MQZ9lXcFLzDE2Ykwb+8Wm5gx+ordD7EQxkmcS45P0E6uk7GZnhuaeh069x6H0KoEHSIKA58nfVs
 5r0XXSexj+81IATdH+zKC6mtGZL7Lme0jvulvWJjxAVM2WWtbMT2X1jatuW10rVrm93LBCKp2D0
 RbzhD8Svhh5rK6Q==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: XHJzW9F7L7inkQkvNVnN-M6n4B8H8XxT
X-Authority-Analysis: v=2.4 cv=eeUNubEH c=1 sm=1 tr=0 ts=6a0c6328 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=r78XHnC5kAO70zNBxnsA:9 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDEzMSBTYWx0ZWRfX/jELlwhKkXaZ
 Op1AyjGNurC8S7oRCAccPkr03Xsvd5Nm/RDUI3qYh2XYPA4mVZjRpLOngx8UN7uypuPMaDhktQ7
 E5pGeYnMXNgc5iV4zQqCqG6z6ug54i0StdA7Ut1djhshbvo+AcZEsPKI3zxoXO0haUogATABFcl
 OBVuF2lQQeQYkYb/6AmTylUpXoQnY40ICaLb/5nbWWy90DgHUEN7wAOVVE25rnpGnIE3UmarXHW
 V2PcKsTbSehPmeOUtRj00rdQpxal6DD347jg/JgOrsnqvyrQ1Yq1gAZAWTAube5tpcKBemUg8I5
 KKUwX1EXphD0c/q0PzVF7v6fdBfzlWJmbC5JfUTalOXk9JL39+HjsWC7/h0xQ8y9QNjxJFyx/cq
 noGId+1Z9nH2+wdKxOCELDyG31WztQrOwcBiVuJVMYCe7qaadDegag0giWgxcclm6PIKoLBhHE7
 ToVWW0OjjbeF0ZzxQlg==
X-Proofpoint-ORIG-GUID: XHJzW9F7L7inkQkvNVnN-M6n4B8H8XxT
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10546-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com,codeaurora.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
X-Rspamd-Queue-Id: 66E8157F841
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Switch to devm_kmalloc() and devm_dma_alloc_chan() in
devm_qce_dma_request(). This allows us to drop two labels and shrink the
function.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/dma.c | 41 ++++++++++-------------------------------
 1 file changed, 10 insertions(+), 31 deletions(-)

diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
index c29b0abe9445381a019e0447d30acfd7319d5c1f..3db46fc0c419a0a387abce93649084fbf4b1f128 100644
--- a/drivers/crypto/qce/dma.c
+++ b/drivers/crypto/qce/dma.c
@@ -12,47 +12,26 @@
 
 #define QCE_IGNORE_BUF_SZ		(2 * QCE_BAM_BURST_SIZE)
 
-static void qce_dma_release(void *data)
-{
-	struct qce_dma_data *dma = data;
-
-	dma_release_channel(dma->txchan);
-	dma_release_channel(dma->rxchan);
-	kfree(dma->result_buf);
-}
-
 int devm_qce_dma_request(struct qce_device *qce)
 {
 	struct qce_dma_data *dma = &qce->dma;
 	struct device *dev = qce->dev;
-	int ret;
 
-	dma->txchan = dma_request_chan(dev, "tx");
+	dma->result_buf = devm_kmalloc(dev, QCE_RESULT_BUF_SZ + QCE_IGNORE_BUF_SZ, GFP_KERNEL);
+	if (!dma->result_buf)
+		return -ENOMEM;
+
+	dma->txchan = devm_dma_request_chan(dev, "tx");
 	if (IS_ERR(dma->txchan))
 		return dev_err_probe(dev, PTR_ERR(dma->txchan),
 				     "Failed to get TX DMA channel\n");
 
-	dma->rxchan = dma_request_chan(dev, "rx");
-	if (IS_ERR(dma->rxchan)) {
-		ret = dev_err_probe(dev, PTR_ERR(dma->rxchan),
-				    "Failed to get RX DMA channel\n");
-		goto error_rx;
-	}
-
-	dma->result_buf = kmalloc(QCE_RESULT_BUF_SZ + QCE_IGNORE_BUF_SZ,
-				  GFP_KERNEL);
-	if (!dma->result_buf) {
-		ret = -ENOMEM;
-		goto error_nomem;
-	}
-
-	return devm_add_action_or_reset(dev, qce_dma_release, dma);
+	dma->rxchan = devm_dma_request_chan(dev, "rx");
+	if (IS_ERR(dma->rxchan))
+		return dev_err_probe(dev, PTR_ERR(dma->rxchan),
+				     "Failed to get RX DMA channel\n");
 
-error_nomem:
-	dma_release_channel(dma->rxchan);
-error_rx:
-	dma_release_channel(dma->txchan);
-	return ret;
+	return 0;
 }
 
 struct scatterlist *

-- 
2.47.3


