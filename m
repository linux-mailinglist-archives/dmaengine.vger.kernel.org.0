Return-Path: <dmaengine+bounces-7408-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CF212C942D1
	for <lists+dmaengine@lfdr.de>; Sat, 29 Nov 2025 17:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EE3BD342ED8
	for <lists+dmaengine@lfdr.de>; Sat, 29 Nov 2025 16:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FED31A065;
	Sat, 29 Nov 2025 16:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="cuKgls/T"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010018.outbound.protection.outlook.com [52.101.229.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5027F3191BD;
	Sat, 29 Nov 2025 16:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764432294; cv=fail; b=LaPkkjCUZbtPfE/kVjDirlHGrA9glw2M1CCazsfgxs9bgMrYFAJ9h9eqKFKO+t3CW0oy8fe0q5t1ImsrBDvqq0XsP7Q7FldUQHydRoPijvASi0qt1R6tN6i5q4JpQ5uqePBpQHAkKoRrscfASBR5IPBmcsQgtS036DU5IJiNERo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764432294; c=relaxed/simple;
	bh=Hjec9pAJcR61KE/D1aRut5sXnPG1iF+bwkk2Pq+uxvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TXZxtcfCNsH4DbV5LNmRDdv7NAr1pk5So6pke50R5PqsNoJVBHYSgvanNifr2jnjefO4vFVrLP01U5AsQNbIl9J0jY6hGLPuyzKljSUonWKBjYZ9NxfL8lIvEBWg2UKYLxC9NaOZEMalxt+8wO5Nc9C1961qXJF4MOrYHjxxIho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=cuKgls/T; arc=fail smtp.client-ip=52.101.229.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NizmWOa0IIjozbOzFc+JmgrX9YL046oaQhgQnPjMYpGT3yGKYaakh/YjQlJ7LHXbS4h3t9QXIIw2LmY/Pa6DpTLjcHkmY8MKvx8leqJSMNxsF2emNtKT8K7owVPxexaO6Mqf8/zo2LKB0nRFnJIQ9AsNv+totFm1nBEWPTV++S80jISgGiNUghkrdrkcCUlsVm+HL+RqoIc1jsbMP9s6LkuQjbszBcdJF/jwiZY3ytUfJdQpbq2hfHj8KhBZlkWwtrPB5CI4uzKxcmBmPDZzkZMoiakKWs7ErDZ3ovXvzEr0UcHvpDJQOlsR7tJ+gW/e95heCuR3TzuCH5UZnpB+Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTrh6OFoGhP3INq2Kn06zksGW96ZF/fWvsP0lWgZnpI=;
 b=Mnge9vsKF2APbI/z23DQ4iI38e8KjBIIxtb7GMfDvmPq9ZGe/hJ38rKRoDgiPBIujjD/DiJePRKiQ9aphtnHmK7yDaoprs+/wTChRFzLr58Pr9eQUhmI0PJoAKMuwCvncvuJtx1DCLolYNDnwuf0LHkdW+GqC5M0q90MopOicjIYVzbyyGdzqjdhgYnDKQSJd18mRL/OIiE4IMqIMXqvLKxOrb+KeVhe4eg03XuS/UP9A7CL4v0IKiU0eryRAdH1NAlsrnwKmEQuWkRwD4vc9K3UC6XyMdprtnHYDUoaVJmI043/ZpMnqia5YwnJjkohEC22oO+rgEFF//e6aBdMhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTrh6OFoGhP3INq2Kn06zksGW96ZF/fWvsP0lWgZnpI=;
 b=cuKgls/TKrNcvT5DIn3QqQnYRMMqjwgVsdaJCOAP2JV5wGFHdDwdTikYg9doEXRU8ZdGGE825t44F3O+RpT0iXMn9adWnb9QMVAjxmgLaWOt+xdL+xJI4nbmt9gusWU4koWlCtWb1N0T6deKd0F0NtF3dUz3WWZ0M//9WUnjsWM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by OS9P286MB4684.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2fa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sat, 29 Nov
 2025 16:04:42 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Sat, 29 Nov 2025
 16:04:42 +0000
From: Koichiro Den <den@valinux.co.jp>
To: ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Frank.Li@nxp.com
Cc: mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	corbet@lwn.net,
	vkoul@kernel.org,
	jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	Basavaraj.Natikar@amd.com,
	Shyam-sundar.S-k@amd.com,
	kurt.schwemmer@microsemi.com,
	logang@deltatee.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	robh@kernel.org,
	jbrunet@baylibre.com,
	fancer.lancer@gmail.com,
	arnd@arndb.de,
	pstanner@redhat.com,
	elfring@users.sourceforge.net
Subject: [RFC PATCH v2 23/27] NTB: epf: Add per-SoC quirk to cap MRRS for DWC eDMA (128B for R-Car)
Date: Sun, 30 Nov 2025 01:04:01 +0900
Message-ID: <20251129160405.2568284-24-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251129160405.2568284-1-den@valinux.co.jp>
References: <20251129160405.2568284-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0144.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::8) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|OS9P286MB4684:EE_
X-MS-Office365-Filtering-Correlation-Id: 61b84d6e-addc-4f13-8244-08de2f6101fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i+sW6a7Uc/Wm3uziiMFx8raZ8u4YXIz8+bd3qtD0Ww2A4+yWwKjbrHKeP56T?=
 =?us-ascii?Q?+Pd1jz23DrvTtxjdIqcvp83kXHBwD6G5/mHdTecVHt6kjXnI4vSb0nQUJIHa?=
 =?us-ascii?Q?5SZhSFEJhwdcJf9RHY9rQ5DLYCXBdnf1gPYAHNL1ORpnYnVsoPdOtSEXqrHR?=
 =?us-ascii?Q?ahtFQhxL/zBd8oN/yNRiwTX2FrqS77D9lqtXxuYVW1B8b9flrySUdErhN5V/?=
 =?us-ascii?Q?3wuleNJ7LDQvAy24VXJHkNApWpo3N0o0XCD0NTtmYP3aw7cflpuykzTEUMfP?=
 =?us-ascii?Q?nn35AwAhAtFMtcRo3W+VQfEyvVmCAAKo/YHAWC2wusLVT/mxjjdAltgeTPSC?=
 =?us-ascii?Q?6R8u2LfVw8qMBVwhZ6QRyJnlvcdui/LjRIMLYw/9/H5UZjRVEpafxUlZwW3f?=
 =?us-ascii?Q?hjTe0/waoDi0tazdiqk6vbZB4txuet7XU1Frr29LmNgp/p4VM9dJhqaUt9rf?=
 =?us-ascii?Q?psSBiFIPgPKDDyCcrxi/2kJWWG6q/9uCp4+1qJXhIlREdO8Nzs59YlyjRGyg?=
 =?us-ascii?Q?Vaf1vQVUiKezE8CxLW1WR7OcTHCJRaTeqVggIB1ZhiOUa1zovDwu0urcRLau?=
 =?us-ascii?Q?aX0ExMYK8wMwmNWvaUmcvCPCmQ6FEdSpA1uXr5yPH0Oaxs8sgyqCKLNaZfFV?=
 =?us-ascii?Q?2Hw/Bt/VRTcBVbcecTO3tBaotn8IJWdTq7Thtnxq7DEXg18PjU/+S6jhzWak?=
 =?us-ascii?Q?ykYXAoK+LblRHj5PYvS59dx1cjdlU2C6i1LNe7m4q9oHJo0T3SJFdiuWUYrd?=
 =?us-ascii?Q?IumlcZsu6QynGgL5mJha9o+jVccrevGVI9QZoNBp+8BgBFbO9LCKIGp+TbVp?=
 =?us-ascii?Q?1fq95KM9znxYAW2Jn5q/J7s4HwBDQ3tbB4ooysveAbqn5550vIdngW2UboJA?=
 =?us-ascii?Q?b6u3loNKcQFdqWGqgo5UuM9sfc1xLVcaoHyUF/bEsfeKBSqNEqmM1A2Iz3rD?=
 =?us-ascii?Q?qYKFjA/SqWUDQ50a9PShVy6v6n1c7M3W3mCXF47zr+o6FtT0wiimXgO7M433?=
 =?us-ascii?Q?sjc9Q61WsY8liDmnmTYl8rUOocqLUpBi/lAkon08SnjQOZ/svf+WeJSnXhPk?=
 =?us-ascii?Q?BBOpNI0uUulvzWmKvNEibMQLAxg8cA0lw9k56OsfJxc5pvIHPZl9aC5yTsoP?=
 =?us-ascii?Q?4hTPxsOoa6F6Zh93W4tpRim9IRzWsI+HEQ82CxoFALSu3TZsvXzIPYJNlo2f?=
 =?us-ascii?Q?eMvyxYxh3glk83ejqVZUvrUj06s6aRPe6jyX7ADHbHTYU+2eGgM7RoolNOP/?=
 =?us-ascii?Q?ZJ0bOVNnfctvrSKHQck7XnrBup7gtKF6r+IreVx5zcMuRvIZBTm4kyMnjOhv?=
 =?us-ascii?Q?bbmrRMnfOQQ/zp3koF9zo0wXSIcmzxvrFf0oppHfQqSGB97+GrH7RUbaqniQ?=
 =?us-ascii?Q?LAQKEG5eIY1Hzqv/4DhsO5S7IHk7JLMFTuoVaRKYrznBWsSRDNqRY4Z+QJhQ?=
 =?us-ascii?Q?Y5S23ky7TNqnq8n3k9EZ7bsacbxXHRWR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7RNx8x+Qe/VNSCpZpWqrFurt2ZqoybXX2XYnX00YzNt1hzzX4UaS48QO2g5y?=
 =?us-ascii?Q?Zgy6XGYe0jB1hBSth+ectGBwqaYaLwUtJj9ManWI+QKKft53JMAghhfiBpRw?=
 =?us-ascii?Q?ax6aJTbngnNaNtkDjeJ6miHGDd7B4zpnmQhhZpSPduRF+aamv5E3RKK2ncNg?=
 =?us-ascii?Q?iIFN23iyWDtp0tdnwlKZoSpK21M3HWuOCtOA/jaeHNZgGIh31bqmGxvATR6a?=
 =?us-ascii?Q?fn60j+vrCaB1xE3U1DmS5rjVd4ef14tGoYnuw215Oqf2LDio1RA9LZHdUn9u?=
 =?us-ascii?Q?eiwuw2LD0jX7lzpZLrmQd6zGpFQYGbUBZkZ2Nj2ivfWmKpO6gT5yvhfDRY5d?=
 =?us-ascii?Q?a52n1OJkBh5yVWseWfpKVPLX2Eb4XrQ9wvIEbU7mMKLzqozGAi56i2+Zvef9?=
 =?us-ascii?Q?MT1AnztBQqWVebfogGWTCVlrBabxRWnne4aCmJX2Q4yncNwp1ApUOsr9zQQI?=
 =?us-ascii?Q?bsI7Gaw7T1LCSw3Lf+oVXHgojDBmviNmTJmvgPZ0CDwAMb63mZzTx7tV35QS?=
 =?us-ascii?Q?zmO5ooTyoIdHL3mcabdfI/rNjSVr1/ZMSjLGKKNvYxAhs4i8wcH7udOZzMN2?=
 =?us-ascii?Q?WxzOsdkKNNf6np6d/UdIZj+Da31guld+nV8zq6GNvaWziAiMXaO+fOcJt17/?=
 =?us-ascii?Q?WEkRIQdoKAnIJKGu5UDYrpwp7Zgm02Sb+jAlW4ch0ZRJ7zuwRy6q5E31EyJ7?=
 =?us-ascii?Q?jHPKjr3UHYA7NpDHhxtUnSGnBIrPRnCHihoRMSDeDbkMmpOLuiTQ4p0nFNgX?=
 =?us-ascii?Q?ZK7KNmg3NfUR7ohys2CmEtrLxUfiscGJ7TruqlMywKnrBJxApxCHrH8Sr47A?=
 =?us-ascii?Q?RnpYkmgIZvZdwwTcN/1WLtc0fGNBaVTaMjj3+mHboFgOudsPR0f9JGqriPXh?=
 =?us-ascii?Q?xpk81OrKau1W0d+T/GHWLeMjfKncALxDt48zM/CZEt8EE6apn6Ic+uaIkcwg?=
 =?us-ascii?Q?R26EVjrbaOezj+Te09E0CoCSeGuRGjXwMkwMxVCaRlqMSmHkeFa0/yAQac8/?=
 =?us-ascii?Q?rsBNcLyIq+QMJpNnetcY4lpZQx/0RYvZRWjLGaZRFiKDvBH1LGh1F4kaByka?=
 =?us-ascii?Q?4KUE0GWlKSQlqZXMA9gqyquACExuYjRCPluNTI49zMLr+iRpP8S5SPSdqD9S?=
 =?us-ascii?Q?s3paebW48twTsuKewA6NrZ5hHj4GUEmUnP031AW4R9F1yirAckoTH/IuJmjr?=
 =?us-ascii?Q?oI+RLu9zSCpQ9bnz6+Zq/NZFvLE6NnU8qkg9BrhwPFEmlcWyPEeqSayCUWYH?=
 =?us-ascii?Q?F/Z2xAO27MD11Jg5IdrpFxJDSotgz7l2pbg/Uplox88ScfatH8DStXP+Me+u?=
 =?us-ascii?Q?v2eZsllNgdNVXiXj5naww1+rK7mEW7pGis64JG8oJqqMrFDWCWJr9HgGOeZK?=
 =?us-ascii?Q?eq+oqCluTAzHCM7mfg0pC+UsOaD2q/fvKbl+6AVis3cY/cIo+2wLr6eBVEWA?=
 =?us-ascii?Q?YuM/Hso0NSLMid34378IdnKBd9vxe7+SvH1TyqPJ0Atal/SgLdZM8aw+CM9M?=
 =?us-ascii?Q?/iZkEW/94WWN9yeXDOpVaIvN4qBOxqZ3BAtdGrBkhY3vlVw2TJo9ABckPYjn?=
 =?us-ascii?Q?jLXusgjyyEiAP5ufUn6ZfSjK6xW7v8qJGOsNrr7vwZm0v4uuSlPmnAgJ3KlM?=
 =?us-ascii?Q?8FedtebwTPgBq3LMT2nP8vo=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b84d6e-addc-4f13-8244-08de2f6101fe
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2025 16:04:42.5790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qn0ir90prLkzuAvAFsSP5p/2/CkbWOENmY165LbYRiTVKAlFffkI14BK8SHzb4nuSOJGEa+8ThuWQ6DB3BPF0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4684

Some R-Car platforms using Synopsys DesignWare PCIe with the integrated
eDMA exhibit reproducible payload corruption in RC->EP remote DMA read
traffic whenever the endpoint issues 256-byte Memory Read (MRd) TLPs.

The eDMA injects multiple MRd requests of size less than or equal to
min(MRRS, MPS), so constraining the endpoint's MRd request size removes
256-byte MRd TLPs and avoids the issue. This change adds a per-SoC knob
in the ntb_hw_epf driver and sets MRRS=128 on R-Car.

We intentionally do not change the endpoint's MPS. Per PCIe Base
Specification, MPS limits the payload size of TLPs with data transmitted
by the Function, while Max_Read_Request_Size limits the size of read
requests produced by the Function as a Requester. Limiting MRRS is
sufficient to constrain MRd Byte Count, while lowering MPS would also
throttle unrelated traffic (e.g. endpoint-originated Posted Writes and
Completions with Data) without being necessary for this fix.

This quirk is scoped to the affected endpoint only and can be removed
once the underlying issue is resolved in the controller/IP.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/hw/epf/ntb_hw_epf.c | 66 +++++++++++++++++++++++++++++----
 1 file changed, 58 insertions(+), 8 deletions(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index d9811da90599..21eb26b2f7cc 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -51,6 +51,12 @@
 
 #define NTB_EPF_COMMAND_TIMEOUT	1000 /* 1 Sec */
 
+struct ntb_epf_soc_data {
+	const enum pci_barno *barno_map;
+	/* non-zero to override MRRS for this SoC */
+	int force_mrrs;
+};
+
 enum epf_ntb_bar {
 	BAR_CONFIG,
 	BAR_PEER_SPAD,
@@ -594,11 +600,12 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
 }
 
 static int ntb_epf_init_pci(struct ntb_epf_dev *ndev,
-			    struct pci_dev *pdev)
+			    struct pci_dev *pdev,
+			    const struct ntb_epf_soc_data *soc)
 {
 	struct device *dev = ndev->dev;
 	size_t spad_sz, spad_off;
-	int ret;
+	int ret, cur;
 
 	pci_set_drvdata(pdev, ndev);
 
@@ -616,6 +623,17 @@ static int ntb_epf_init_pci(struct ntb_epf_dev *ndev,
 
 	pci_set_master(pdev);
 
+	if (soc && pci_is_pcie(pdev) && soc->force_mrrs) {
+		cur = pcie_get_readrq(pdev);
+		ret = pcie_set_readrq(pdev, soc->force_mrrs);
+		if (ret)
+			dev_warn(&pdev->dev, "failed to set MRRS=%d: %d\n",
+				 soc->force_mrrs, ret);
+		else
+			dev_info(&pdev->dev, "capped MRRS: %d->%d for ntb-epf\n",
+				 cur, soc->force_mrrs);
+	}
+
 	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
 	if (ret) {
 		ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
@@ -690,6 +708,7 @@ static void ntb_epf_cleanup_isr(struct ntb_epf_dev *ndev)
 static int ntb_epf_pci_probe(struct pci_dev *pdev,
 			     const struct pci_device_id *id)
 {
+	const struct ntb_epf_soc_data *soc = (const void *)id->driver_data;
 	struct device *dev = &pdev->dev;
 	struct ntb_epf_dev *ndev;
 	int ret;
@@ -701,16 +720,16 @@ static int ntb_epf_pci_probe(struct pci_dev *pdev,
 	if (!ndev)
 		return -ENOMEM;
 
-	ndev->barno_map = (const enum pci_barno *)id->driver_data;
-	if (!ndev->barno_map)
+	if (!soc || !soc->barno_map)
 		return -EINVAL;
 
+	ndev->barno_map = soc->barno_map;
 	ndev->dev = dev;
 
 	ntb_epf_init_struct(ndev, pdev);
 	mutex_init(&ndev->cmd_lock);
 
-	ret = ntb_epf_init_pci(ndev, pdev);
+	ret = ntb_epf_init_pci(ndev, pdev, soc);
 	if (ret) {
 		dev_err(dev, "Failed to init PCI\n");
 		return ret;
@@ -778,21 +797,52 @@ static const enum pci_barno rcar_barno[NTB_BAR_NUM] = {
 	[BAR_MW4]	= NO_BAR,
 };
 
+static const struct ntb_epf_soc_data j721e_soc = {
+	.barno_map = j721e_map,
+};
+
+static const struct ntb_epf_soc_data mx8_soc = {
+	.barno_map = mx8_map,
+};
+
+static const struct ntb_epf_soc_data rcar_soc = {
+	.barno_map = rcar_barno,
+	/*
+	 * On some R-Car platforms using the Synopsys DWC PCIe + eDMA we
+	 * observe data corruption on RC->EP Remote DMA Read paths whenever
+	 * the EP issues large MRd requests. The corruption consistently
+	 * hits the tail of each 256-byte segment (e.g. offsets
+	 * 0x00E0..0x00FF within a 256B block, and again at 0x01E0..0x01FF
+	 * for larger transfers).
+	 *
+	 * The DMA injects multiple MRd requests of size less than or equal
+	 * to the min(MRRS, MPS) into the outbound request path. By
+	 * lowering MRRS to 128 we prevent 256B MRd TLPs from being
+	 * generated and avoid the issue on the affected hardware. We
+	 * intentionally keep MPS unchanged and scope this quirk to this
+	 * endpoint to avoid impacting unrelated devices.
+	 *
+	 * Remove this once the issue is resolved (maybe controller/IP
+	 * level) or a more preferable workaround becomes available.
+	 */
+	.force_mrrs = 128,
+};
+
 static const struct pci_device_id ntb_epf_pci_tbl[] = {
 	{
 		PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_J721E),
 		.class = PCI_CLASS_MEMORY_RAM << 8, .class_mask = 0xffff00,
-		.driver_data = (kernel_ulong_t)j721e_map,
+		.driver_data = (kernel_ulong_t)&j721e_soc,
 	},
 	{
 		PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, 0x0809),
 		.class = PCI_CLASS_MEMORY_RAM << 8, .class_mask = 0xffff00,
-		.driver_data = (kernel_ulong_t)mx8_map,
+		.driver_data = (kernel_ulong_t)&mx8_soc,
 	},
 	{
 		PCI_DEVICE(PCI_VENDOR_ID_RENESAS, 0x0030),
 		.class = PCI_CLASS_MEMORY_RAM << 8, .class_mask = 0xffff00,
-		.driver_data = (kernel_ulong_t)rcar_barno,
+		.driver_data = (kernel_ulong_t)&rcar_soc,
 	},
 	{ },
 };
-- 
2.48.1


