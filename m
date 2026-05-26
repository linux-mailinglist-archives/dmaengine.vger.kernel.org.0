Return-Path: <dmaengine+bounces-10946-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDnCC3WeFWr9WgcAu9opvQ
	(envelope-from <dmaengine+bounces-10946-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 15:21:57 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E5B5D652C
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 15:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9955E3112BB8
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 13:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115403FD133;
	Tue, 26 May 2026 13:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GimBwBjM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BPZlrBbA"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D8F3FC5D1
	for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 13:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779801096; cv=none; b=uUEy1N4h2tBIYY45BT8kfx81eC0QxsNE5TsfaFObFJd9lfmBpXzfafhy0lpSTDmodXwAY2TAsESU68mGpf8OsVB7MDuLs6cmQlAEpXQunl7PKNJ5HW9gMHIHuE7K4MglWKyT3/Sk6KZNQv2x83g/LspGcWHLCWrXNfUxbitCt3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779801096; c=relaxed/simple;
	bh=atD/C70BmAbtLpgtk/gvN3TNLFsQT9cfTHvoiJm5/zo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XEqDqI68kZgclZe0tqA4U8YtrZwW0K09Bs2X9ZJv5arCm9ie1uKFJUw+P05zY1ivLL13DA3XrxlP2Ese6zE+AKRXKbktf2nRk7tHZ5M7hdN6leXbGNnw48o+D7Z0VtCD/pR9C1F6HrYcmW0k7bJiHxdANCyn7dP30FewyHI6hAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GimBwBjM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BPZlrBbA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QCsdRi1163862
	for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 13:11:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t1nmBooCYIL6gijj0RhLOpiyGlP850IpBxaJF2Uaxp4=; b=GimBwBjMGP2fclBL
	AKTWRMQn0pV40D2BED3S/IHANk4+2s3Hqm3BEfrhTZjsUVYVZEm3wQKL6zL/uCYa
	XsqNhUBT1IIhmJ9SD8zypKE50zX/Or6/rzM73vlVdIgZAUJzhIogcQ65ZIbUe+TZ
	bTG4SiNE8gZ07p4SYA7B2KP897aZiCwsMIhUiKQ0yXbM6hP/fT+CLvB+yJIOFjFr
	qnoB5Rtl+OFXdvpN9yM9Ji7/rmuXK+oJE+qDcDCNvh8eBLDeFbZHHT/gGald/1JD
	YuI5Al59xQFokwRrfbwZO+9D7XPwJvcz/USZlbRWIXyOii7UZCoC3QGnvQG4Xj7D
	QkJc+w==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eckyqn4fh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 13:11:33 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-956804755faso9987521241.0
        for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 06:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779801093; x=1780405893; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t1nmBooCYIL6gijj0RhLOpiyGlP850IpBxaJF2Uaxp4=;
        b=BPZlrBbAwj1O4QcFHZe1sGli54zbfAKoo9mbu3TMxcKs7oDlmLBuPW8wBhYgQIcDVA
         AuR7VmrjOnN5KEMss/5bmgU5oGFA3Kx4ai5TKo5YEYQetAk6Peg+Hh2c04IB+Xh2Snss
         as+3fCtA9/p+CW3KQYoGOJxlEgVusaMym4mnrQQz8l0iIk79zQgEY8IQEjWB8LMuu8/t
         NeyaedJkfE4X8CvXWcQQuESxo0jpCLTD/9MAtIS6zLc/2GVb6kRlxho5OIBB74t5mTU8
         xvQuj/istiB7cKJ9O0e6CX2Q5ixoJWnOZLYytPyWqpRkeEvzvOlFA/LA8cQm3mM+1FXv
         BRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779801093; x=1780405893;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t1nmBooCYIL6gijj0RhLOpiyGlP850IpBxaJF2Uaxp4=;
        b=V6plCwHpwlHbr/c54xMKvo05zgr8h7G5aQgTpblhQs2iAc1yyQ+cB/otZLXFjLhVmO
         Z1ZcpjxowbG73+x22I79q7WWX0Eu6/0Fxt8g1+bO8HuaNqjo6nJeZ/TSayJcJI+1enIu
         +4GoCcB26UkbxPBkVCKgLMhr3Sg9p/RGfX8EBdDXR9C8yRTK6x79LttlRSBmC4gMGHCa
         Qkb8oaOQaAXfvGQUFIhRPHsdE+LSSw43g3guYKsmngV+ODN7rvAm1I7mPd8nxtxEgvUs
         EqO5bn6CVoWq0ogb4LvnQLgtTVAhGZU9RJif+8kuvmhHU0mqE3i02mYL24tpufopxc32
         dH5Q==
X-Gm-Message-State: AOJu0YwtFFn7siHatkcHdQKmxRvEobhY0E+JxmkGo+r4OmirFNaDlOBf
	EkA1MdHG/GXsmcGaVWW5vJDH22mdDKyzJlM1R4k+5j/ra+rvB4cG3KSkyzxWWheUI4h9HX2/oJ9
	bolqVCPc1ymKGjDjMxvhOz5zX/pOhIsaGRAKrJLeUQD1DesDsk2reyRC/FTRjros=
X-Gm-Gg: Acq92OFeyprgwHm7KLxJrbHirUyY1/1G4ti8AyfTDURWRdI6Vz40xu31+GOBo5DU3j4
	SrIICKzgXh5YQkJMHNHG3nQt3vrcFlFtv4pld64ce0DxjlPBREaBnJaDJa2PK/Yk89YMKh0ERLO
	5U+7XqYbNY+4c+JUXWjVrIWGQFRk8oqkTJAT4D78GkApuaE4g3xHnWjTpWPK/9yP/nRIIl80Y/B
	0lbk5axp9s6iTdnp5Pg22kJGvmzf3oH0riHyuVPOvAyYWKm9vIXuybxSiBlHGRnlpuB6z0CQzQo
	7XctICoX+VNwkCPgEBtBXkmnGj0bRWIbNqj5wiZ0Hf9t3dTLh70JDlEbaJwIG1mxjjVrxSFdhZj
	TiNda3/Wox7ytf4X2j8MGuMpObeA2JswpdOE9MJiaXA5IkfQ9J36uqJcHnGXn5A==
X-Received: by 2002:a05:6102:1453:10b0:633:9ac8:6bfd with SMTP id ada2fe7eead31-673bf88569amr7323113137.4.1779801093236;
        Tue, 26 May 2026 06:11:33 -0700 (PDT)
X-Received: by 2002:a05:6102:1453:10b0:633:9ac8:6bfd with SMTP id ada2fe7eead31-673bf88569amr7323089137.4.1779801092792;
        Tue, 26 May 2026 06:11:32 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:15ba:1d70:65ea:9578])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d5e484sm34259426f8f.30.2026.05.26.06.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 06:11:32 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 26 May 2026 15:10:55 +0200
Subject: [PATCH v19 07/14] crypto: qce - Cancel work on device detach
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-qcom-qce-cmd-descr-v19-7-08472fdcbf4a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2419;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=atD/C70BmAbtLpgtk/gvN3TNLFsQT9cfTHvoiJm5/zo=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqFZvub4oPxpUvAbSVN4B/pj5xEWuzyl0SR2VFe
 rF8kbhuJYaJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCahWb7gAKCRAFnS7L/zaE
 wyeFD/46/l63yuSUdQlhfYT4OY/W+59STZtAewnx+aiAWACncqNoBszVXsTs7wsrckSz0VvVGaS
 29ESTPTJbrPNF7es3LUrk+dZ9e1clxUNaDDw1v1p2wk7Ppy2itCaDxO6TGOL8VNWUC5ppAv5e31
 gZprPnxh62JRjqFBqTEGLOGLLyVHy9jAVdPNvD793KQb+egpZrFw0MTMQZf+Rq2lQl4bmboXt6D
 +U16DuZPtw6KXxPUg7UQp/SSey+jiFr/zUd0Xb2juh9TsvXOK7V24UTJc1/ooLH4ossJwVJDpON
 lcrCUrOANF9NvsSDH74i/UYjXzr0NGMyy7fAXUwiJ45U7ofzg2/JMcBNY1i4VPSucL/504OEKDR
 vlaocEYX313WRsXI1Q4MLru3WQbJ73qX3JgPdEDE+Oitdi1hr9cXfXbrMXRlzq0bVv36LFXOsuF
 jFgZeOcS/W1qT5lDsj9XukBwleBmYfvray2BDzRftHqKmq3xGtTS4ThOhHPthm3NEFpO3IqjsG7
 C70BRz+oqcQGrXxSN6pdJ1fs6RGdcsy0rVf8GRIKe1PYyLX1XBE2SduPJNKPNfRR/mFWZzci0gm
 8wlPzyCSzk4I1SynlWAl5Zk0nVrkI7EzK+tCmLAqHdYYAPfLqepSXqqjC+JjeiwriryO+BRrG6+
 bA8kjd5gU5WehkA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=RMyD2Yi+ c=1 sm=1 tr=0 ts=6a159c05 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=c92rfblmAAAA:8
 a=EUspDBNiAAAA:8 a=SDQHpg0AWQOuS8LWovAA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: qnWdakEevWtmENpkYRksZ-e1gN8Ccm8z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDExNCBTYWx0ZWRfX4FdCOhzPHXHl
 Y/izZViD4mCW3K9Shq4iopEJ9QLw41bcRWz/leLEPhKA8f3ecDBZzs1c4/dbqb+g38EJ1HxyInc
 qJ5zxo0+FROKPGv6bCF+Kfv50WBe07AjcLzzmbDhS0Ly5SQ0H4xDkGzLOZK2H/344pdAHpKL6BZ
 AAemvbqVHWSA4VWg8GDM6ZKiZbQ2ApMB+fBJcjHewb1FS6ZXcBf/CsdV/2HZzOeOLN3tXT7WSP4
 MQX0H5ItQlUbzXbNtO7W6VOdyxEbkAvIDu5OCqmNFUYHndvOoSSjZA7UWFUK7WO/3UWTA5vKmPw
 3kYyK6wnPon3FAbF9P30R5tSgZHHdrm7v7t4JYSzsNFS1lZ2SQysUx37FWRDkHwHP0Sr7IYnCtf
 fqdJUpo4Dn1eCtm1PJiS/EI2jYEgqOXTVzObCF05OY1+wC+rsPdAgNTDcsjPsk+xYam9jDoa1/U
 UM8OelzPNLaPqZSiNcg==
X-Proofpoint-GUID: qnWdakEevWtmENpkYRksZ-e1gN8Ccm8z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260114
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10946-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:email,qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com,codeaurora.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 97E5B5D652C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The workqueue is setup in probe() but never cancelled on error or in
remove(). Set up a devres action to clean it up. We need to move the
initialization earlier as we don't want to cancel the work before any
outstanding DMA transfer is terminated. Make sure we do terminate all
transfers in qce_dma_release() devres action.

Fixes: eb7986e5e14d ("crypto: qce - convert tasklet to workqueue")
Closes: https://sashiko.dev/#/patchset/20260427-qcom-qce-cmd-descr-v16-0-945fd1cafbbc%40oss.qualcomm.com?part=7
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


