Return-Path: <dmaengine+bounces-10469-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMIpHT9uBWrkWwIAu9opvQ
	(envelope-from <dmaengine+bounces-10469-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 08:39:59 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8EF53E6D8
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 08:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF94F3036480
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 06:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4AB3D0BEC;
	Thu, 14 May 2026 06:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dXoWS4Jf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VHIWsr/8"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5675138D3FD
	for <dmaengine@vger.kernel.org>; Thu, 14 May 2026 06:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778740786; cv=none; b=bRgOrLl1wcmDU5c/UzF+lz+p01TbFJCHD+1v8L2SMKJ2Jzk5pnbgcfooUqZfKxkaB9E2LDUjMBnHb4zTv+VoBwS0e8m9yjteNXZvNPPOg1VHUFnnErHf8zI0aeOLLzLNwsZQzEig6Wzc7VNG1ICq306D249VdQo/pmoV1TuqxVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778740786; c=relaxed/simple;
	bh=33wvNA1sFIp+E1wuxvP8wRhsnpkjwg+enxY5nkRVyIk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=A2NZgdKPnkdfvXdHsXZyixMPOXdBn5Z6JPcjUWxE8KDvYnhbevoiloaENlc0X0T609ilX3gIUKyJh0Ntcuu4Z5ebDx3NMoIH44qZ84FDuq6OSUL7ubh/8cIVB9qfo735uEZ0pvzgwOyVQVn0UKLygk+zodMI7ow4LPs3hkcK/ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dXoWS4Jf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VHIWsr/8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64E68bF71965378
	for <dmaengine@vger.kernel.org>; Thu, 14 May 2026 06:39:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=fWBwrdEVK+wLwEYEZFwGGu
	eAVc/ezl4neMbcKjSTtPU=; b=dXoWS4Jf7cCaRPT4eX47pDky/rD+N3RGdaVVCb
	69vE03UCYhPV5DoXNAQMz7WNjsWYyoD/wo3NRfxY2QSwdEkqnGw3dYZFdGIXw6cx
	RxyaMOvzkkOr9cwpMCKTL74bwQGMNT+VQJJmYOfH9u6xd+RLvTs/FzyC8V+sud8m
	1hE4FJAHlJH5q8rhKUEDWvVC+gGVAbg0OHHywx3yX1ud0tdgTzDglSdD6oPswvRl
	3TxwrKd+ia2DHt9fE68pLa3ie93lR75tClxN//yt4rbbdq4dmuPyF5EjSSkJIKLn
	JT8E0ByiJAqoeLipIpF9kwFI06O0QhspLXS621v6b3qyqhvw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e58v8838x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Thu, 14 May 2026 06:39:44 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-82f6a5b4f88so9563562b3a.2
        for <dmaengine@vger.kernel.org>; Wed, 13 May 2026 23:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778740784; x=1779345584; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fWBwrdEVK+wLwEYEZFwGGueAVc/ezl4neMbcKjSTtPU=;
        b=VHIWsr/8gB4rsgXRlEuJiJxTqiu3/0A6756nSpk931SLLcgMh6d3xektoF3SjG0NKa
         vQOHdShz+sMkEfK0aY+chWHABiTG2q0iybA+KiI/LrJCWue+9986om6rAp8pPTIsj1EH
         HXxIAPpKdGpLCI/CtaxxUTgPbf6o8Esh6+dm7RuaKsM8JSdZKDkVx+YPmL7zbWZI6Wx8
         PkYCcP6a/Zv+kbMujMorLxK9y7cqgzUanm4mxyhalbvK2+wCBu5ofYQUPhykDndxJ4xg
         HXIQRSS04N+LORbKCjzugdnf2+PbgO8U9NCxa9V7URfaiiJiCzaT8AA+wGwuLHxmC0Rh
         bhsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778740784; x=1779345584;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWBwrdEVK+wLwEYEZFwGGueAVc/ezl4neMbcKjSTtPU=;
        b=fcMrh98Fq53p6nsT94y9k/23YzVki25/ZUd4zdFsfWMvUSt64WFt8jrmTHfSyzqRTJ
         xz2WumNZvLHMytc2YCNukI72kcoql0thkUXr8Hn4o89gDrEB1ubqdtKzSA+hOb+wxQ7F
         nPMXK1eoWiGPXqCeFtYL6wxiBSvXAiBeXogBYke+QtIH20WSLgNI2AMKW/r7a8R8w44y
         P1RqG9AZfLE8UrPiAmVNVjW9oZo85gezpwWIcuU725wj1u/k8Ntq8zSUIoHbzkeRn61c
         imoUKpWPX88TRviEcHRLMCAr00Mf/ZV/XntdLgR0f3erERTnDeRys92uKCyh0B+lMzX4
         HuOg==
X-Forwarded-Encrypted: i=1; AFNElJ91plE3vaXe2NYxG5BSMA/9cdFWTu6rPkCQM24X+QtHOfd6gjXGWGpQzbIpr48s1dVrzTd8TQx8G5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwafCC+swXcFghw5Ec6rwbILqpz8VlbmIaeU4KmGA5Peibx1G1z
	UtUoxQ6ASexKCzz/H1OiqwxEyZdGihgX8+rbtCvCfDTq+fBbW9pa6J1iy7Q0hWj8Kgr7+T3yFVL
	L80hUiM2OPH5Hlr9i9iMnqL3oFfhQp/pUsTiMyWiUMg4AHyRHCRboaAvgHtfmT1s=
X-Gm-Gg: Acq92OEaECKn1YbSYoPliz2HJwtrGj0MsHV6yIyb6BFqQeHXSISozYXOadqXqiYQRdb
	NvI+iebAB+lyCq6lIhcwxTlCbdWE81gF1AK49UYRli5Fp7xw1RbdsCRM+jkW1aWCtpM1w1HRq5T
	/eJSQhfjSw/K469hRZN5TTWinSpg4H6Uo/rmC9rQ27r9V3asdxygVqInUeI+PAdcK9mh18I7zyY
	TH03xAN6EfqOypQO/O+xK59ZmCFM4A3fPvNAR7dw1I9pI3dyAoXOiuwRG2wMGDAatOygqpjSgq9
	WZgvXsBABmeqxWGWALsSsQJ3QT/2Qx8bddY1gnOEY8JP1u08cdGWW90mAX3URlKcykMrx8SiP0b
	/jG8uqcEolgMEga6uR99iwE9k9io/0nJdeo5LhRzjyPdr8tG3tPOpDIEFUxkDww6RZUiirwHdwq
	j4WgoeNq+NBNLsoCvN0FpA7A3jkNhLf+n+MlLV4H9ApK2xcr4N9lY=
X-Received: by 2002:a05:6a00:32c5:b0:835:443e:4bc7 with SMTP id d2e1a72fcca58-83f03fa7c68mr6897633b3a.13.1778740781355;
        Wed, 13 May 2026 23:39:41 -0700 (PDT)
X-Received: by 2002:a05:6a00:32c5:b0:835:443e:4bc7 with SMTP id d2e1a72fcca58-83f03fa7c68mr6897590b3a.13.1778740780706;
        Wed, 13 May 2026 23:39:40 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c7c008sm1461826b3a.46.2026.05.13.23.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 23:39:40 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Thu, 14 May 2026 12:09:29 +0530
Subject: [PATCH v5] dma: qcom: bam_dma: Fix command element mask field for
 BAM v1.6.0+
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-bam-fix-v5-1-58f6edb34969@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIACBuBWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyTHUUlJIzE
 vPSU3UzU4B8JSMDIzMDU0MT3aTEXN20zApdQxOjRIPUVAsDU/NUJaDqgqJUoDDYpOjY2loAr5Q
 WZ1kAAAA=
X-Change-ID: 20260514-bam-fix-142a0ee8057e
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Abhishek Sahu <absahu@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Md Sadre Alam <md.alam@oss.qualcomm.com>,
        Lakshmi Sowjanya D <quic_laksd@quicinc.com>,
        Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDA2MyBTYWx0ZWRfX3JX4HGjyeXgM
 jcBbKxkca33q1Touei2YwX7d6dm2qRNt6OFDAuaL90mzn4QOnlG8VJxlICsZFXXj0tApcZ/nlof
 2etNAMACXDbDTQFbZ5lO3X49/2ST9hA4TUjubbKA1v07Bot6Es3X90/lgv6FRAsLEtFf7AvKmfH
 T+PvHoCaPojhXruulOXpXWAzDs4KgwvDoVEYd65IlUxbQGDscD7qDoSpIRZHXR6R24UOffNZ6iY
 BN+ODLAnWngav3OU9pJWIMp81Db+XEV06zXwG1dbOpCf9fsXhkF2/36McQlXrXCMEW2NSwXZ7au
 5G9VliHZxwgE1de3Wr0MIqsXnsjc8Baa/gAsXMOFXiAWwWfqVAwQ6h7C1EKv9pl6H9NeqfTxtk6
 y7T553QhN4rXgvUFnjpi+lbZd9N7v35W2ctdp1TiBLHD8B/R6JNG4kQUsGW2HjzcKnEUMrwqIqL
 lGw4NHF1tQO4gSENhaQ==
X-Proofpoint-GUID: YTgJ7HaqZXPYfqtIaSSY8k27SRK45fUU
X-Authority-Analysis: v=2.4 cv=YZSNIQRf c=1 sm=1 tr=0 ts=6a056e30 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=Y3rUfbXbY1px-OtE684A:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: YTgJ7HaqZXPYfqtIaSSY8k27SRK45fUU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 clxscore=1011 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140063
X-Rspamd-Queue-Id: EE8EF53E6D8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,quicinc.com:email];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10469-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FROM_NEQ_ENVFROM(0.00)[varadarajan.narayanan@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

From: Md Sadre Alam <md.alam@oss.qualcomm.com>

BAM version 1.6.0 and later changed the behavior of the mask field in
command elements for read operations. In newer BAM versions, the mask
field for read commands contains the upper 4 bits of the destination
address to support 36-bit addressing, while for write commands it
continues to function as a traditional write mask.

This change causes NAND enumeration failures on platforms like IPQ5424
that use BAM v1.6.0+, because the current code sets mask=0xffffffff
for all commands. For read commands on newer BAM versions, this results
in the hardware interpreting the destination address as 0xf_xxxxxxxx
(invalid high memory) instead of the intended 0x0_xxxxxxxx address.

Fixed this issue by:
1. Updating the bam_cmd_element structure documentation to reflect the
   dual purpose of the mask field
2. Modifying bam_prep_ce_le32() to set appropriate mask values based on
   command type:
   - For read commands: mask = 0 (32-bit addressing, upper bits = 0)
   - For write commands: mask = 0xffffffff (traditional write mask)
3. Maintaining backward compatibility with older BAM versions

This fix enables proper NAND functionality on IPQ5424 and other platforms
using BAM v1.6.0+ while preserving compatibility with existing systems.

Fixes: dfebb055f73a2 ("dmaengine: qcom: bam_dma: wrapper functions for command descriptor")

Tested-by: Lakshmi Sowjanya D <quic_laksd@quicinc.com>
Signed-off-by: Md Sadre Alam <md.alam@oss.qualcomm.com>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
Change in [v5]
	- Split the driver change into a separate patch
	- Update commit log with 'Fixes' tag

Change in [v4] - https://lore.kernel.org/linux-arm-msm/20260206100202.413834-2-quic_mdalam@quicinc.com/

* No change

Change in [v3]

* Added Tested-by tag

Change in [v2]

* No change

Change in [v1]

* Updated bam_prep_ce_le32() to set the mask field conditionally based on
  command type

* Enhanced kernel-doc comments to clarify mask behavior for BAM v1.6.0+
---
 include/linux/dma/qcom_bam_dma.h | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/linux/dma/qcom_bam_dma.h b/include/linux/dma/qcom_bam_dma.h
index 68fc0e643b1b..d9d07a9ab313 100644
--- a/include/linux/dma/qcom_bam_dma.h
+++ b/include/linux/dma/qcom_bam_dma.h
@@ -13,9 +13,12 @@
  * supported by BAM DMA Engine.
  *
  * @cmd_and_addr - upper 8 bits command and lower 24 bits register address.
- * @data - for write command: content to be written into peripheral register.
- *	   for read command: dest addr to write peripheral register value.
- * @mask - register mask.
+ * @data - For write command: content to be written into peripheral register.
+ *	   For read command: lower 32 bits of destination address.
+ * @mask - For write command: register write mask.
+ *	   For read command on BAM v1.6.0+: upper 4 bits of destination address.
+ *	   For read command on BAM < v1.6.0: ignored by hardware.
+ *	   Setting to 0 ensures 32-bit addressing compatibility.
  * @reserved - for future usage.
  *
  */
@@ -42,6 +45,10 @@ enum bam_command_type {
  * @addr: target address
  * @cmd: BAM command
  * @data: actual data for write and dest addr for read in le32
+ *
+ * For BAM v1.6.0+, the mask field behavior depends on command type:
+ * - Write commands: mask = write mask (typically 0xffffffff)
+ * - Read commands: mask = upper 4 bits of destination address (0 for 32-bit)
  */
 static inline void
 bam_prep_ce_le32(struct bam_cmd_element *bam_ce, u32 addr,
@@ -50,7 +57,11 @@ bam_prep_ce_le32(struct bam_cmd_element *bam_ce, u32 addr,
 	bam_ce->cmd_and_addr =
 		cpu_to_le32((addr & 0xffffff) | ((cmd & 0xff) << 24));
 	bam_ce->data = data;
-	bam_ce->mask = cpu_to_le32(0xffffffff);
+	if (cmd == BAM_READ_COMMAND)
+		bam_ce->mask = cpu_to_le32(0x0); /* 32-bit addressing */
+	else
+		bam_ce->mask = cpu_to_le32(0xffffffff); /* Write mask */
+	bam_ce->reserved = 0;
 }
 
 /*
@@ -60,7 +71,7 @@ bam_prep_ce_le32(struct bam_cmd_element *bam_ce, u32 addr,
  * @bam_ce: BAM command element
  * @addr: target address
  * @cmd: BAM command
- * @data: actual data for write and dest addr for read
+ * @data: actual data for write and destination address for read
  */
 static inline void
 bam_prep_ce(struct bam_cmd_element *bam_ce, u32 addr,

---
base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
change-id: 20260514-bam-fix-142a0ee8057e

Best regards,
-- 
Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>


