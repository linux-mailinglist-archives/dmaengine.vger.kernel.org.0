Return-Path: <dmaengine+bounces-12378-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cF7QFevjVGpNggAAu9opvQ
	(envelope-from <dmaengine+bounces-12378-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 15:11:07 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE64F74B5C0
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 15:11:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=A26+ncDx;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=YZVgcae5;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12378-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12378-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2301A3283BD0
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 13:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081CC416D03;
	Mon, 13 Jul 2026 13:01:37 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FF5412298
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 13:01:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783947696; cv=none; b=ohiikd1UIwmaeN0s5ub2+ikzu+MkzvrgQ7UObAvzl85c5ydLD7Hrkpd+ab6/sYxihqi61kYGNY75qHNdC1fiQILqicQKWouRCDQdAV+ZWT9iZJOGpVcJA+Nym/vXwE0sALPb1IDguexgWEg2y6eukVNp7aH1VNbEDp3d/7DgOww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783947696; c=relaxed/simple;
	bh=aBAcCkxK8mkjUHreQ6UzfCckqgV7c8TRyxA37AtxAqg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RvprYxWRDydR0cO8P+cFd4lHbpX8hghrBKR5WVN7nffcykPQnXIg3RZLTrneaYvSKQN54THa4HwVLGrXCi5EGb1H1qEvmK6dfXCiuxVS4Qn2W+L0aGAlV8Ez9dVPxyyUA0UKaYpUjdq9NhOh/Knrm/G02xDpos6UCj2hFOEHpvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A26+ncDx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YZVgcae5; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DCEM501333558
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 13:01:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=I9wM5Qm35/bTrJvYcsd40/
	PwY21wEVaYmdAJWRFQtmo=; b=A26+ncDxTuXC8N+X3uibGs8Rap3W07m4Z9x0UZ
	hy9t2FwpxCc/02BJTMptmfPmsH8YLejhy5sAvoplmXHGUE18cWt4luP1AjCwV3on
	HjtaU7nIoGqn5P0dZAFzYJQFPAAlin8UpHXJNddKj5GDh9B75AVqHoH6YwsjV5Ks
	Pw/zJtk0CF3DNIM+9JbWjR6Cd730afiauyfr5RxAoENqyruSIioSF1LucXrXQZi0
	e4sQ+JLm94S/xgDkVip6cVLgNvl0z9U6ytp+oj7pSIRZ8gqHYoV5e09B+XDh28ZJ
	VaicHc7ujR9VDZqnMnJSz+ExY/nT3KVDo1Om792OEu2J7DNw==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fctc8hkf4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 13:01:32 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5954c5fbcc7so1670323e0c.0
        for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 06:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783947691; x=1784552491; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=I9wM5Qm35/bTrJvYcsd40/PwY21wEVaYmdAJWRFQtmo=;
        b=YZVgcae5wQXEQsY0xLGva8bMnIKNei46+Rr6Y+T3yOr2hAmtoUby0ILsPR5x1tSejL
         6gCOLPHMjRW1GqzWcK/H7zpWTBl3z9NzTyOHF12nk/er2IKAj3FPiAvTmZ4v16G2FcFq
         nYnMq9KCO31MuQL2ciN/raX4/r8y60UcsJO1cDG1B1rWmG8Pvv5t2cTJCdu8BWKZc8nM
         8PITwfmz9FWIHmuGERyvpvgURc36LE6t/UukdcTi131k7uPvKpJNCu9rsMvqOl6nyyyk
         RZSI9z71z8lKkryxZqeTKU+wuBQ3Q91mCKuEl14GALfq9Zz+/4kE0rfDc63CdcsEJ8Y/
         09Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783947691; x=1784552491;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=I9wM5Qm35/bTrJvYcsd40/PwY21wEVaYmdAJWRFQtmo=;
        b=QXH3m6fvlva4wz0tYwytdqMwGabk00/SqW2tJgOXf4fT1AviBhbez4b1TGU2i5Zlfg
         rF45VgHv5jNHLbvA2+xw6D0ifK6i+3N2Gduo48y44+/qavGvrBNLCufWl4InYliZoeii
         AvKKsOa2RhFu0tZbFRRaTsU/yEcjIUHUwhUMwS2z30ejQRiEF8eDSQhYrD0Zif3yOmHc
         uTKiTyPxV0vAPgGRU31TfyDqxQQJU4m50b5ILdcq7d82TeG1HjVYlvQoWgxFXDlNOes/
         e6ERnIB+WIOIOuo5tE1WraL3vnqYppUwYDEPfYbcvBo8S6EDKa5B2fUsMk+la8aBUizz
         xgwQ==
X-Gm-Message-State: AOJu0Yx8ZFYp1sRj+3e6iS6rImtFyusmXCz1nlvcd3qfmTwwytki5Z/7
	GwWaUu3ea8PPUTzJFPUsSJJn8+Hqu18DF0kPL0WjFmE6x6CSk1WugN400AgaCGcPy0WquHFery9
	qq4X08xw9rGUzZpevOv9EuFG3i8u9KX6m/BfX+AXtl6M/QZu77+tN0w2692GE4Qk=
X-Gm-Gg: AfdE7cnT1bYU0J0WCT9EchNGl+BIgoT+Tp4Bub99KXw9ZMMpYJTEEduHOc16t+zwCxF
	N+TXdCavvWmv9zHTRuCn+trkpHTh1IpFTJcvDmJ3WE/WA62kNSkdT8QL5tRsUtaWxoli7J62Sd6
	TjdKywaCju1G8hIDx0ZJQJUMd+6UFaLVIphN+DBp+sSQ5QCCiKMypG8ih+ufMTORm0n6jwT5jxG
	C9UsQ9WS6vfVCDL8n3iH1jss+hwx2QemJzs6JxBQo5KMr1977GeJJgI/sUNBa+isXdRuBu8J9r7
	2+dtrSTWOM2Igu0ce7MVE38qbMntX0QijnviNSkYh9iufwlXfMjmgatlzlaRLp3c+94hhvCXg1a
	f/V9IHlSbb+rmidYk6NadY6HdcgfYD0j80sYeujbn
X-Received: by 2002:a05:6122:62f1:b0:5bf:8955:a8ce with SMTP id 71dfb90a1353d-5bfbf06a211mr1671495e0c.1.1783947687585;
        Mon, 13 Jul 2026 06:01:27 -0700 (PDT)
X-Received: by 2002:a05:6122:62f1:b0:5bf:8955:a8ce with SMTP id 71dfb90a1353d-5bfbf06a211mr1671193e0c.1.1783947684660;
        Mon, 13 Jul 2026 06:01:24 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8881:83b8:89fa:1a2a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f2d97527sm306129725e9.2.2026.07.13.06.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 06:01:23 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v21 00/14] crypto/dmaengine: qce: introduce BAM locking and
 use DMA for register I/O
Date: Mon, 13 Jul 2026 15:01:01 +0200
Message-Id: <20260713-qcom-qce-cmd-descr-v21-0-bc2583e18475@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI3hVGoC/3XTyWrDMBAA0F8JPtdBGu095T9KD9omMSRxY7emJ
 eTfOwoNMVQ6WCDZftIsunZznoY8d6+bazflZZiH8UwT4C+bLh78eZ/7IdFCBwwU50z0lzieaMh
 9PKU+5TlOfVTZBc4xa+Y6+vFjyjh839W3d5ofhvlznH7umyy2rD44XeMW27M+x5SiB0GP3h2Hs
 5/G7Tjtu+ItbmWArRqODOcVGgjWGYB/BmdPBLirIpyRgmiyDGiST3I3zvP28uWP9PFpS8OfxR+
 WZoJB3eJkkcNRpSAtg5YFK4sOULWALOEsCoOgM7KWJdaWqVuCLOa0zUGijbJpyZUFom7Jki966
 1FSZUwzX+ppyVa+VKmgDUpoThVIpmXplQWNGHWxpMLEo8cQYssyT0u1esKQpYRXTkkug3Ety64
 saMRYOt05ulYOdPDYPJdbW/VLw0vHMysNYIoBpW9YwJ6WhnqMUPpeadTU9FZGpirW7Xb7BRQKB
 pU+BAAA
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
        Michal Simek <michal.simek@amd.com>, Frank Li <Frank.Li@kernel.org>,
        Andy Gross <agross@codeaurora.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc: dmaengine@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        brgl@kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=12948;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=aBAcCkxK8mkjUHreQ6UzfCckqgV7c8TRyxA37AtxAqg=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqVOGR/oFb1vbJastyh3MtavaUNsUqC7Yl+LvpP
 DGjt+kJt2SJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCalThkQAKCRAFnS7L/zaE
 wxmLD/43FgTmu9LF18Vffa6c7oYyWtblwvVAwX4CcNiTDaThsYskX9iZwCv4trzjsu/8EdnPPWz
 2g0JnCYvhkAnspgt+6fMZk6Ylo1RzhUE6cUVIsGhhF5Bvs7JFxJ/7GpRSvUO43HDJbFM/+cXjW8
 4XzH2uqJYdtmmIdAYE1X4oP/R3/vVpb8/4+w2zEyW9KFzEtvJKxjaCbeZy7BxHdesnHl4Z+NoLj
 Uf7IR+CxlPvl4mNLsZiY8nUYPktYwKLAU2nw5lOYXdARANVqg2nHhksmschMXyPI8mxyr31ICYJ
 jyZwdQBa7Ukj1xCIpM4E4GogG6w40XxE8TUukZ6gv99nVpgcTOSlbB5sGXvr31PQAUwVl8dzl4Q
 YZv6RyvdoSWQiq+Q+X4WzlCpiVL3h2lG0c6rGwY3GyRnWYZepR16sRcBVZHdljJDLTzBFa1A3uE
 wOKY0WcOBUSEKj5Rh34Z8zV115VZP0PG2JAO48xFtagl0es94PuPsMB9/gGBWMMOxFRlxOgKgRX
 tBQUy+pHZTxTBowTCXuYX3Te/SzvHLyynD5N2brgCP/pZoD1fvgRhGb2da41cb1Gi3XfGox0n7z
 4p2bDygCjT29Gsrtu6MJ/ICKm1j+2x9g2s73JHVOLRpeZmjkWqxEDY1zpi+WWzG3VofHekR30wS
 fu7Eee828soViJg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: iDwhjE2MxYuTwG7JWVSIFE2P3gkJDmwu
X-Proofpoint-ORIG-GUID: iDwhjE2MxYuTwG7JWVSIFE2P3gkJDmwu
X-Authority-Analysis: v=2.4 cv=UtRT8ewB c=1 sm=1 tr=0 ts=6a54e1ac cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8
 a=mYVGbHsXlysWdROdmYcA:9 a=GNyJNrYKVWbsGpMV:21 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22 a=FO4_E8m0qiDe52t0p3_H:22 a=cvBusfyB2V15izCimMoJ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEzNSBTYWx0ZWRfX2QqeeMbvJntH
 W/MI1eF324q0/5vGluz5vmPGDN5WcQ6/KBNhs/ojqDA+gGfnF9/+bhSLGXIloxghl5lZsUa+T4y
 8d7IGmHRph5oc/2qsxDqh9E29+V0Jdk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEzNSBTYWx0ZWRfX8lm+BlySfpte
 YVNInsaQAFp67lDirIz/kvL5sekIlHuu2N4GGOVNbzYMtS5zkJcFSo6hZIgp3gxfQ7muuE1/zF8
 5jAJoDlzCghWXYmC5GVKB0P+6ix+v8/CUdDn2HZ2e0oZceEjpzAFIHJW9HCcbSb66TtbX8n44SK
 phSB+FamK3f59jM0MB6MVqucCqQrCCS4eSh6SdPPcWBgjTwHTAj6hOhZ5UREZ+eEYQQsWQKimoi
 ncU+LPYf6KqRpsdemRr8KW2r32Srrh5tISE6iOImJ+ET1C67KvTixFwXB15sNqYqXXmP6rZigaV
 sO5eWX6prT5+hg+k3DRoFR1mZOciZuaqce+YFz2KSxNL91NDcHZyvv83VSeRTgYYoApxCP5IIyE
 dha+Bd5elct2ReZWb6X7MqMWa7MA2oh8Xb+iwohAA80qIsilHu1k77Q4b5e+kVrvLvXvSyHxa1d
 vNnReQauyvdF/xbuSVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130135
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
	TAGGED_FROM(0.00)[bounces-12378-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com,codeaurora.org];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:corbet@lwn.net,m:thara.gopinath@gmail.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:quic_utiwari@quicinc.com,m:mdalam@qti.qualcomm.com,m:lumag@kernel.org,m:mani@kernel.org,m:stephan.gerhold@linaro.org,m:andersson@kernel.org,m:peter.ujfalusi@gmail.com,m:michal.simek@amd.com,m:Frank.Li@kernel.org,m:agross@codeaurora.org,m:neil.armstrong@linaro.org,m:dmaengine@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:brgl@kernel.org,m:bartosz.golaszewski@linaro.org,m:bartosz.golaszewski@oss.qualcomm.com,m:radhey.shyam.pandey@amd.com,m:dmitry.baryshkov@oss.qualcomm.com,m:konrad.dybcio@oss.qualcomm.com,m:tharagopinath@gmail.com,m:peterujfalusi@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bartosz.golaszewski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,msgid.link:url,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,vger.kernel.org:from_smtp,linaro.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
X-Rspamd-Queue-Id: BE64F74B5C0

This iteration attempts to fix another potential race pointerd out by
sashiko.

Merging strategy: there are build-time dependencies between the crypto
and DMA patches so the best approach is for Vinod to create an immutable
branch with the DMA part pulled in by the crypto tree.

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

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Changes in v21:
- Fix a potential race with new descriptors submitted while hardware is
  processing a locked sequence by clearing the bam_locked state right
  after queueing the UNLOCK descriptor
- Link to v20: https://patch.msgid.link/20260629-qcom-qce-cmd-descr-v20-0-56f67da84c05@oss.qualcomm.com

Changes in v20:
- Don't use DMA cookies for LOCK/UNLOCK descriptors as this leads to
  dmaengine state corruption
- Handle re-scheduling of a DMA transaction on full FIFO
- Fix DMA descriptor leak in qce_submit_cmd_desc()
- Link to v19: https://patch.msgid.link/20260526-qcom-qce-cmd-descr-v19-0-08472fdcbf4a@oss.qualcomm.com

Changes in v19:
- Fix more potential issues in remove path (sashiko)
- Remove unneeded return value check for vchan_tx_prep() as it can never
  fail
- Link to v18: https://patch.msgid.link/20260522-qcom-qce-cmd-descr-v18-0-99103926bafc@oss.qualcomm.com

Changes in v18:
- Free the BAM interrupt before disabling the clock in remove() path too
- convert the size assigned to command descriptors to little endian
- don't pass DMA mapping attributes to dma_map_sg() in bam_dma when
  setting up command descriptors
- Cancel the QCE workqueue *after* any outstanding DMA transfer
  completes
- When mapping the scatterlist for command descriptors: use the actual
  number of mapped segments for dmaengine_prep_slave_sg()
- Drop the leftover read_buf field from struct qce_device
- Unmap command descriptors only after terminating the RX transfer
- Pass the actual size of the metadata struct to
  dmaengine_desc_attach_metadata(), this is not really required for our
  use-case but let's do this for correctness and make sashiko happy
- Drop double assignment of bam_ce_idx in qce_clear_bam_transaction()
- Remove unused QCE_MAX_REG_READ
- Link to v17: https://patch.msgid.link/20260519-qcom-qce-cmd-descr-v17-0-53a595414b79@oss.qualcomm.com

Changes in v17:
- New patch: free the interrupt before disabling the clock in error path
  in probe()
- New patch: cancel the QCE work on device detach
- Hold the channel lock when attaching the metadata
- Reorder the operations in devm_qce_dma_request() to avoid freeing
  memory that may still be used by the DMA channel
- Register algorithms as the last step in QCE's probe() to avoid making
  the resources available to the system before the DMA is fully set up
- Fix error paths in algo request handlers
- Don't pass dmaengine attributes to map_sg_attrs() as it expects
  dma-mapping attribute flags
- Fix a dma mapping leak for command descriptors
- Rebase on top of v7.1-rc4
- Link to v16: https://patch.msgid.link/20260427-qcom-qce-cmd-descr-v16-0-945fd1cafbbc@oss.qualcomm.com

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
Bartosz Golaszewski (14):
      dmaengine: constify struct dma_descriptor_metadata_ops
      dmaengine: qcom: bam_dma: free interrupt before the clock in error path
      dmaengine: qcom: bam_dma: convert tasklet to a BH workqueue
      dmaengine: qcom: bam_dma: Extend the driver's device match data
      dmaengine: qcom: bam_dma: Add pipe_lock_supported flag support
      dmaengine: qcom: bam_dma: add support for BAM locking
      crypto: qce - Cancel work on device detach
      crypto: qce - Include algapi.h in the core.h header
      crypto: qce - Remove unused ignore_buf
      crypto: qce - Simplify arguments of devm_qce_dma_request()
      crypto: qce - Use existing devres APIs in devm_qce_dma_request()
      crypto: qce - Map crypto memory for DMA
      crypto: qce - Add BAM DMA support for crypto register I/O
      crypto: qce - Communicate the base physical address to the dmaengine

 drivers/crypto/qce/aead.c        |  10 +-
 drivers/crypto/qce/common.c      |  20 ++-
 drivers/crypto/qce/core.c        |  39 +++++-
 drivers/crypto/qce/core.h        |   7 +
 drivers/crypto/qce/dma.c         | 173 ++++++++++++++++++++-----
 drivers/crypto/qce/dma.h         |  11 +-
 drivers/crypto/qce/sha.c         |  10 +-
 drivers/crypto/qce/skcipher.c    |  10 +-
 drivers/dma/qcom/bam_dma.c       | 272 ++++++++++++++++++++++++++++++++++-----
 drivers/dma/ti/k3-udma.c         |   2 +-
 drivers/dma/xilinx/xilinx_dma.c  |   2 +-
 include/linux/dma/qcom_bam_dma.h |  14 ++
 include/linux/dmaengine.h        |   2 +-
 13 files changed, 470 insertions(+), 102 deletions(-)
---
base-commit: 9c2d57db8bee1d5603f98c1a5a510c2114fb0d26
change-id: 20251103-qcom-qce-cmd-descr-c5e9b11fe609

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>


