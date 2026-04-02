Return-Path: <dmaengine+bounces-9855-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YB5cILqEzmm4oAYAu9opvQ
	(envelope-from <dmaengine+bounces-9855-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 17:01:14 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EFA38AEB9
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 17:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59591304CE81
	for <lists+dmaengine@lfdr.de>; Thu,  2 Apr 2026 14:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE7C3EF0A1;
	Thu,  2 Apr 2026 14:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C0cJ+uHV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P+tylTQS"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F753ED5A2
	for <dmaengine@vger.kernel.org>; Thu,  2 Apr 2026 14:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775141757; cv=none; b=i196oUcvQJM+E2ez2SHs1I4P0AX+bzcnMepm+B9VEMUBeLdWO4afTw3VVMV9kFJlk2mMR/bxqvmh4NAvfOoNBA3KaKm9+/NblWch584GY+EIw70CuhZ8MUowUxrI0uEePXw6mzt1RL/kwwbZQECHqiqStC7gOJzgfYdR/b7G+Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775141757; c=relaxed/simple;
	bh=9HTS4fZ3H+lFANDn5LMcUa1sEWyLefaj6bErjMWxbGA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cujqWbIbwc/UqH/4rewA+ZNDBGc78ZOJBy1LZFi9O1IJq10nIPNycS3FV9QaPBkrCtWTJ11Ilyy02hsOrHrrHipqCC1SJEEli6ODeM0T5jlzvzQeVhfSrbX1YP2FM12Mvs28UEbuiLGGpODRPlPbTVs1BVqe4SYcZWaWrj2dV10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C0cJ+uHV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P+tylTQS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632BW0H3948883
	for <dmaengine@vger.kernel.org>; Thu, 2 Apr 2026 14:55:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=5v9zMJNPjpSTtFQa2UP54Z
	4SnDZvPgOCBNMoFPOzTAs=; b=C0cJ+uHVvBZ+ku9t4IWrTZsgDisrhoqZiJa/JY
	lx/qH+oKT0/Ls2+lkSuIG7ADjpdspP3UH4AOUqwZHaaZ3vxb0DK9SO7FH4ZxLjKO
	mJSj/01aODXbfbtYJEPzETjjfwxdfi0C0CweRNz32cb7n1zZDvTDCkHRuaw4FaUY
	8Stiew9CxAid1DkKFY0Aqf1FLA65EMALxfCQOBPyHBtEF0LSy4O23OVxzEtKvXnq
	XmfOjTPiKQzkh/ztE7354EhJDWbgPe9x+lwGkUxtYYZ9PIrT5tD+aYKl+EDwtwFs
	mOCPlhftOXypsic8ltb4CE0DPP4HJiywkpcf3vz1KraHGJ9Q==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9qnu0u9g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Thu, 02 Apr 2026 14:55:53 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8a0d03df951so30336366d6.1
        for <dmaengine@vger.kernel.org>; Thu, 02 Apr 2026 07:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775141753; x=1775746553; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5v9zMJNPjpSTtFQa2UP54Z4SnDZvPgOCBNMoFPOzTAs=;
        b=P+tylTQSjl84ZBut2rE8/gBm1L4cO5lXHi1/bllaE5ofYmHYIDKh8lbRpJVnNbf80G
         kojS9x/LWpQNpuAeaAS5vjyuEqHMcdKAESLSQM7SHgHlMTyyhk5CQzzsIDQ2/SdO56CU
         ra5N4BurdhMZ/nONAIuToMEEHksnPSzeXAKHFH6Rcpfw3R0AliL3M0mYdM+u+E6FZJJy
         9hzFcuXeFKYAn++N/U5lN6tEAiVGBxXzyIf478Vhg8IBixzZsoTLUFIXwu4M6fglmgAj
         2LEcX90k5F3KlKWi8BeVmMyup+s+otMQFUTgbWwQSZnAm2LqB3IPNZlv2fsDxiTYkwM4
         WZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775141753; x=1775746553;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5v9zMJNPjpSTtFQa2UP54Z4SnDZvPgOCBNMoFPOzTAs=;
        b=nagvlUbjR1T2hpdr7u/lGpdcxAajaZLE4UKis+UUtMEMpeZ72ntxEqrHs8E892VhZs
         VmMi/bVVu0y8K9ALsqsPTJitDW1BllFfxQVMskhTKwZz631Q4I2kFt96iyxk8U8iCMrO
         FSl4lmWIN4MiqvalsV6f8r2+E39XBi0DrwYGZxVsZLop5AmWbYq0mVjsmTtqWwrjxcDl
         N8wPDGl5tVO4CBOU5oL0T9mmIHD5PX1/hkfEE271gfPlkHileqcMX7U5M0TxQmsOL535
         KNJgoCIz409dUkUj5lOYEy5ogTXFHOecsl/ZhNnXnCTBagUzPRI92BYYp9zO3j5DErNJ
         CA5Q==
X-Gm-Message-State: AOJu0YxUjKL3iCPbOkZKmhqnlmXAX69BZX3KYVv4N5VX7LTBKDd3Wl3c
	7HxYYLsjg8R4xuXgN43rzb3TEv32xgJ0bTLMG2ZYCmsshKaM9ZTwr86iv23GUQ34zNWJ5joIUp2
	ie5Z/yG0Jk6BWNdW7NkxHpRVtm2OcmJi/WaP2548rAj5W4pNiYwXKxzrs8kpj4bk=
X-Gm-Gg: ATEYQzxqotKWKUSNwYxrctCVMMmTFZb1H8yZRNvMdK/8vq5Mueu/FbwNpd/2dne6ymm
	Q5wBJ+YT0Tz3Q0PczidZNjEipv9kc0ZphCES8SU/KmNrLur+YNURqs+V/49alz9gkSkfUL3ZPBU
	lMKaq4ZEa1Mwn9Us1+ymstmnxk4OqTi+tuEQPoIH33Tq4Ss8e/MdP0NlF8mO22B7yUJ6D4fiVaG
	sHsaYOcFVzKxd0iwjCErA75WOIZHYozVq7qPPXaZrfFdhQmgHOosjMwVk1NRMunEq4iX/CSx8yZ
	bDqG5572ltxoK2+dNJkGO0ZQVulWLIXTEhAs+LfvlKkf1ZpsOyHUSNatA54xrpDnxIRvXb5Ghys
	Xg9JR+ZUSuYeJmgPyuktoortqwU4eLw6WC1NLA01GKvxCz56XtKae
X-Received: by 2002:ac8:7d03:0:b0:50b:6b39:4df9 with SMTP id d75a77b69052e-50d4bba6211mr51260011cf.30.1775141752660;
        Thu, 02 Apr 2026 07:55:52 -0700 (PDT)
X-Received: by 2002:ac8:7d03:0:b0:50b:6b39:4df9 with SMTP id d75a77b69052e-50d4bba6211mr51259341cf.30.1775141751975;
        Thu, 02 Apr 2026 07:55:51 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4ff1:3e57:22ec:dadc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4f5294sm7234038f8f.35.2026.04.02.07.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 07:55:51 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v15 00/12] crypto/dmaengine: qce: introduce BAM locking and
 use DMA for register I/O
Date: Thu, 02 Apr 2026 16:55:11 +0200
Message-Id: <20260402-qcom-qce-cmd-descr-v15-0-98b5361f7ed7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE+DzmkC/3XRwW7DIAwA0F+pOI8IDAmwU/9j2oGAaZHapoUt2
 lT13+dWqxZp5IAlG3hG5soqloyVvW6urOCca55OlMj+ZcPC3p92yHOkAgMBvZRC8UuYjhSQh2P
 kEWsoPPToRikTDsIxungumPLXQ317p3yf68dUvh9NZnuvPrmhxc2WC44hxuBB0Rq2h3zyZeqms
 mN3b3YLA2zTcGQ43ycDo3UG4J8hxR8C0jURKUhJyaAek4k+6u1Ua3f59Ac6fOwo/FryaQ1CCWh
 bkixyZOrjqK2ANQsWFj2gaQFZytmkTIIBk1iz1NIybUuRJdxgcdTJBr1q6YUFqm3p+7xo1ydNP
 2Na87rdbj8hk9FndgIAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9691;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=9HTS4fZ3H+lFANDn5LMcUa1sEWyLefaj6bErjMWxbGA=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpzoNkH+K2t7d9VEYrkQ+bxfDT/2MpwDhDu1tvj
 /joyUJJL++JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCac6DZAAKCRAFnS7L/zaE
 w7CxD/0ajtu4iYpjOcpfav/T0BlpjGAd+UsaeLvRmVSGeF0jQvj0rmJVYy6sIOcq0CL8Jo2lNWp
 NZRcgbjwwcWejtSgdcTjbx4kh12s3YUwjMkqH2mxugGzrbYzgshlpdPJR6PR3SvZBoirdUF2gES
 KhXOgBlJ8Hbh4thBFXYxJ57IZVory6dK+wNGs70QD7WsG3MjNRmc1taDq2Yb5rGmvIXA4kqVVFf
 MmFQma9unFTAB+y53vEPsCiDLXOIpyNopnkLIWsmKwZlfQWVgKO81ud2UsptBaQ3Ejk7ZvcqUxO
 FHp+7GdZtGp97JipDA5MF+SoK4Ci+BkuoUq/uG1xQfrIYXyyZoXMx0O8d35ebTjlxf8QZ6jQBAt
 RE5a63zrzP0dlrToUvLyQ3Ag3/SB8PkOYMqKMGji0dnf4TyjHVRmL56YhIexGKffl+TXxU0Iy7Y
 mZ5afQgn4KQsugW8+GENq0gEdl1idINyxpTT6XQejHp4uUDH9nBpdEMBj6KYkgC2hYgMw9JrmIE
 PLulTIKg9uttbVZHlf1hxLLBqG7v0qG+cYqNN4xYL1O8/gn/4SzyiMwohUsXTq+WqpVNiaBSHkg
 flmLDB8L8G99ppe+U6Ubg15ItFLs+z9BbPbB6pvaQ8u1HMER3ZX3lY05C7eV6hsVMcLfa71BOIp
 QRDU8mYZbXudCSA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: YT4ez1FjnpxZ5AMQaTfU6mk0D0pvoDsT
X-Proofpoint-GUID: YT4ez1FjnpxZ5AMQaTfU6mk0D0pvoDsT
X-Authority-Analysis: v=2.4 cv=RoLI7SmK c=1 sm=1 tr=0 ts=69ce8379 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8
 a=uGVhH4IIQU4n5J_wZqUA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=FO4_E8m0qiDe52t0p3_H:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDEzNCBTYWx0ZWRfXwjt2sZru4OJ/
 9f6zZfjF3T1r3XScBA43CbBs3u1SvZ0uYAKCgzi0LgmO+vVeHgABs4W3geHKE/Wk2IJXuHkJV42
 aiNPxdjXtoufF3nusBs9a/wqoFlxcEGOVjZc5RrNspGMJKVhRVY4d9HBhPSoXmBr2XIh4yIfov0
 2Ywa/TX7+dpWNLoAlj54LtviHedM4j0eFMfSyVsN/SMU8alq1JW742Ws2ntaTvY4IDcRHHx7u+O
 plhXA3WwGiLDDb/DjLqRic1AnGVoOSbsX4yYHCTHb5NQ5GPl28dgjWFk6yaI/UA/GtpzxiyPZLy
 7V9ByHL5Ojzb7vmNZmj1eMiLIJhr0HtJC0NbBmPoP4smOvZUIteK3DHt2mndTpSnVpzd/xOFqFx
 dmEOJwqx/oyPkXKNZLwaJuFcfatIuws3aIvuuS6qUDtV6GorAKXmhe0Knw99wZHjQHXycokPddh
 VXhV2+xl2jdxp9OLm/A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_02,2026-04-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020134
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9855-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linaro.org:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D8EFA38AEB9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This iteration is quite similar to v12 but uses the BAM's NWD bit on
data descriptors as suggested by Stephan. To that end, there are some
more changes like reversing the order of command and data descriptors
queuedy by the QCE driver.

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
 drivers/crypto/qce/dma.c         | 161 ++++++++++++++++++++++-----
 drivers/crypto/qce/dma.h         |  11 +-
 drivers/crypto/qce/sha.c         |   8 +-
 drivers/crypto/qce/skcipher.c    |   8 +-
 drivers/dma/qcom/bam_dma.c       | 230 ++++++++++++++++++++++++++++++++++-----
 drivers/dma/ti/k3-udma.c         |   2 +-
 drivers/dma/xilinx/xilinx_dma.c  |   2 +-
 include/linux/dma/qcom_bam_dma.h |  14 +++
 include/linux/dmaengine.h        |   2 +-
 13 files changed, 416 insertions(+), 89 deletions(-)
---
base-commit: f09c0150ae6cb6eae66a75ddf6f0e890182594bc
change-id: 20251103-qcom-qce-cmd-descr-c5e9b11fe609

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>


