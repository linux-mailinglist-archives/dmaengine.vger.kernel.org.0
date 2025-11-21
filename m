Return-Path: <dmaengine+bounces-7291-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D5CC7A99F
	for <lists+dmaengine@lfdr.de>; Fri, 21 Nov 2025 16:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8DA1734669A
	for <lists+dmaengine@lfdr.de>; Fri, 21 Nov 2025 15:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45162E717C;
	Fri, 21 Nov 2025 15:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=corscience.com header.i=@corscience.com header.b="ZfZicAua";
	dkim=pass (2048-bit key) header.d=corscience.com header.i=@corscience.com header.b="ZfZicAua";
	dkim=pass (2048-bit key) header.d=mail-dkim-eu-central-1.prod.hydra.sophos.com header.i=@mail-dkim-eu-central-1.prod.hydra.sophos.com header.b="EyEBGjfK"
X-Original-To: dmaengine@vger.kernel.org
Received: from FR6P281CU001.outbound.protection.outlook.com (mail-germanywestcentralazon11020112.outbound.protection.outlook.com [52.101.171.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80C22ED154
	for <dmaengine@vger.kernel.org>; Fri, 21 Nov 2025 15:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.171.112
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763739661; cv=fail; b=LeV6tJMHkbQ4JiOSoIQIxFqzZ2WHnFJ/cxYTMUZT4ECexP32SWHvxOq4h5chLrHZR/aylVk0VebMSK6wtIPt9ZgINy+Er6R6DpBJoIKOnRR/Hna7Hlh83IPpYlqwI2dbaCl3S1Abk84xDFO/s4/H3yV9LHx3xxDzpsYNT2EnlmY=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763739661; c=relaxed/simple;
	bh=VdKNsp1UQALq4iT6q/4dBdmPAA1dwwSs25qjxoKO/gQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Wlf2vamdA13vpRYFR6XtZyLS4ClATekhiEaSufat2clxwLdx7SlmK1HMfdSd98Ipfj/jNKdnG1JYsufR8T1RwOdsXv8Gn3ZrWPO0oQf+ryr0FwVnDvN3bIzuxPshwXgGohQxWDpcI/d+UZSo1lspJ3nZeA24YoNSvJ44I0Gqg+U=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=corscience.com; spf=pass smtp.mailfrom=corscience.com; dkim=pass (2048-bit key) header.d=corscience.com header.i=@corscience.com header.b=ZfZicAua; dkim=pass (2048-bit key) header.d=corscience.com header.i=@corscience.com header.b=ZfZicAua; dkim=pass (2048-bit key) header.d=mail-dkim-eu-central-1.prod.hydra.sophos.com header.i=@mail-dkim-eu-central-1.prod.hydra.sophos.com header.b=EyEBGjfK; arc=fail smtp.client-ip=52.101.171.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=corscience.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corscience.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ulrVEm/PRKjOfSBQ+6nZYvPJ5i59eKGkO7qxWU8RcJMTtNOEXL2fecCeapfIenyHIWHDpvcXg/NKz2N72IWlSejkWYjChtBNCUDDuK2iZiRUslqk/GWNNggZ3bLTA1Efs2YjJR9HFNtwVtFwUvLyOF+5IWP/hYm4rjdyXbR78oXWfADIosqhQafHsQ4CBnee5NzGuaANoYAlildFf47ZFY3y5S9foBP/eWKWBNKoOgoBvusjF+AGdCa6KpSabfDGF3SuwXzhFnYJbDpNR9i+cLDfySA4etDqH1WGOxDUQp8yFJjUegCUi2SLYGPHDWIdjY79lZw5v3N0YYIVC2gPUw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YzFAaa++YcLafs36fSdaVPQLZwsnY9pLMqIvIU5qA2o=;
 b=rDwN25AyMy4eBjyDpNLgDkWia6TA2p09Wv2PVp3p0CbHvARLwaaPUlRxqhVLnTXDmZmsuiCpOpwUqMEgfGIlccjb3Vf5uEA4VGfaki3gyACO1SD5j3JlFR42n8JWrIB738UMO4qaiBKD7LplSRNgazfeiRStaNbpWBHIbcH33AQ9HgKe9d+Q8uKqNAO+kQXtGqUQAY4O4kJzdNzv21Z29fHdpUF/PUAjPqMQLEKJ27aUVoiBzUdJTXHZ3+yo5sIUoOHIZyemkbcDICuseNlEw1PYYDXok0s9zqGYMxom25J0eD51WRyJpRun3sla7XROr7XulrOiF/Kwtn7lvyPgDw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 94.140.18.226) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=corscience.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=corscience.com; dkim=pass (signature was verified)
 header.d=corscience.com; dkim=pass (signature was verified)
 header.d=mail-dkim-eu-central-1.prod.hydra.sophos.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=corscience.com]
 dkim=[1,1,header.d=corscience.com] dmarc=[1,1,header.from=corscience.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=corscience.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzFAaa++YcLafs36fSdaVPQLZwsnY9pLMqIvIU5qA2o=;
 b=ZfZicAuaPD71YhxdXkMzNNvpAEhuxW9NLnfHkwl0K4076XxmYC4OOA+uNPpj/KCzOhWZeFlrBo34kdveAvVumzcQyDBsWb620dXJH5SFjDO7X0aQaXbqAg8MdYMgrw8zfiyOWjJRJvY8TTTYOGMSLQCNqenjtreiwO35cgKsKkxLvlC55jUZ/1XIDYT+QvdzJMQlZyWReOkjORHvFfQ1nMP9eEqh8di8ojU7rRaT05Y4DL0DeA/uvbhVe7RUTyu6KHfJTxej1q6COBbpvDBWFfJgVulnJ2wvP/TZVDznjR725jpiaagG+5nzu6ilkzahmXrYndu/3BG2wcBPC8HyDw==
Received: from DU2PR04CA0197.eurprd04.prod.outlook.com (2603:10a6:10:28d::22)
 by FR6P281MB3790.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:c3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 15:40:47 +0000
Received: from DU6PEPF0000B61C.eurprd02.prod.outlook.com
 (2603:10a6:10:28d:cafe::67) by DU2PR04CA0197.outlook.office365.com
 (2603:10a6:10:28d::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Fri,
 21 Nov 2025 15:40:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 94.140.18.226)
 smtp.mailfrom=corscience.com; dkim=pass (signature was verified)
 header.d=corscience.com;dkim=pass (signature was verified)
 header.d=mail-dkim-eu-central-1.prod.hydra.sophos.com;dmarc=pass action=none
 header.from=corscience.com;
Received-SPF: Pass (protection.outlook.com: domain of corscience.com
 designates 94.140.18.226 as permitted sender)
 receiver=protection.outlook.com; client-ip=94.140.18.226;
 helo=mfod-euc1.prod.hydra.sophos.com; pr=C
Received: from mfod-euc1.prod.hydra.sophos.com (94.140.18.226) by
 DU6PEPF0000B61C.mail.protection.outlook.com (10.167.8.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Fri, 21 Nov 2025 15:40:46 +0000
Received: from ip-172-20-1-204.eu-central-1.compute.internal (ip-172-20-1-204.eu-central-1.compute.internal [127.0.0.1])
	by mfod-euc1.prod.hydra.sophos.com (Postfix) with ESMTP id 4dCfZ61sDbz21wC
	for <dmaengine@vger.kernel.org>; Fri, 21 Nov 2025 15:40:46 +0000 (UTC)
X-Sophos-Product-Type: Mailflow
X-Sophos-Email-ID: 74e005c9f32d49ce85b3aab8b23cb155
Received: from FR5P281CU006.outbound.protection.outlook.com
 (mail-germanywestcentralazon11022131.outbound.protection.outlook.com
 [40.107.149.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mf-outbound-eu-central-1.prod.hydra.sophos.com (Postfix) with ESMTPS id
 4dCfZ45JFxzqSHf; Fri, 21 Nov 2025 15:40:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XGkHBdRv3VOIiz0iFsePwOSK8dWSxbnimcIGVDPZUPVEmC5u/aWs8LrqKMEkQvTaM6ujI6ajGChON1RAGn9y1YiE3t7H4st9zjm5s8RWhhUD/3lv62mJJrCRB8biMGpP+pBArf62aiawVxFqqL1VQG0WAfGC/3b7Z1o+76or1Beao3tKnjqYyxp8W3RZ4XPVoihRTX5uIifSEj3AaPatQK04tODjfm59VY1vkXAFREIOMwk3qXMta7yQ4etZ6/98LGZohefTJFlp1r3/71ZbLuxDIzyUkmetFxaUTvtu26Pcbe4CxkJxNw+YfYln7ie58UaXhIqzsRRp+Eu/BW71Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YzFAaa++YcLafs36fSdaVPQLZwsnY9pLMqIvIU5qA2o=;
 b=c6DTvaSGXgSjI1exk7bNMn069unerLjzdhUKRDbSAz9hoNRaS6K+wsVFiczFr+q8QMOWJ1n1gppWmmPVci/qArIwy8jB5Vs+jP7MOc/zQeTbWWuPLRe8TrrpKNZEqzC8PdbInAHYKCY21f/EP5n3Hz7SYkBfDWMg6XtTjcTaIs5R2QJs4fzjhk9IcH80dpDaCymfWaFHuhJUeZXXT1wKJ8c95DxESOCEuqy9Yn2B5c3yZKfVmnm+n1FXfmhYpCoqBdlQ9DI3LylLkho0ucg5l9c0J0rfhBDSkuNXwTfXVm7qS7N5kHoMq7Ba0t06oZwnXqs4bbefIid9W4oBAD9Tdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corscience.com; dmarc=pass action=none
 header.from=corscience.com; dkim=pass header.d=corscience.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=corscience.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzFAaa++YcLafs36fSdaVPQLZwsnY9pLMqIvIU5qA2o=;
 b=ZfZicAuaPD71YhxdXkMzNNvpAEhuxW9NLnfHkwl0K4076XxmYC4OOA+uNPpj/KCzOhWZeFlrBo34kdveAvVumzcQyDBsWb620dXJH5SFjDO7X0aQaXbqAg8MdYMgrw8zfiyOWjJRJvY8TTTYOGMSLQCNqenjtreiwO35cgKsKkxLvlC55jUZ/1XIDYT+QvdzJMQlZyWReOkjORHvFfQ1nMP9eEqh8di8ojU7rRaT05Y4DL0DeA/uvbhVe7RUTyu6KHfJTxej1q6COBbpvDBWFfJgVulnJ2wvP/TZVDznjR725jpiaagG+5nzu6ilkzahmXrYndu/3BG2wcBPC8HyDw==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763739642; 
 s=v1; d=mail-dkim-eu-central-1.prod.hydra.sophos.com;
 h=Content-Type:Date:Subject:To:From;
 bh=YzFAaa++YcLafs36fSdaVPQLZwsnY9pLMqIvIU5qA2o=;
 b=EyEBGjfK54vU6IpD/B/GvWf3UrN4Plmq1yeiQWZrjRaq/AupYarIaHmeJsmuPTde
 /4RUXrZ8MzgMMiHMIZ8JeGcmodX9fQRcpZZDBbHQ7VhwZA1yrf7N/dS7w0fNAXO4hk8
 SATF8vuRc4CM/5Fl0Z4LJSYcEz3DPyc4ou/XlJUOyNo7+EbxHKQ6ZBeb64gAhabn5A/
 ZVOQuzQDIGu65InFdYij1zBwA/HRGFxMmIpV7B7YsERzOJHF9r2hqoakh2oFgxRU5Rb
 SHfHV5k/l4QpgTAGUl9yc8ZCQvqmHi2OQMngHjgFVkclmjYlGw8p2D+cVOPxe+dqwIQ
 qp+ck8d+LQ==
Received: from FR2PPF3F1788DC9.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::27)
 by FRYP281MB3034.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:6b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 15:40:43 +0000
Received: from FR2PPF3F1788DC9.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7d59:b366:80c8:60e9]) by FR2PPF3F1788DC9.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7d59:b366:80c8:60e9%6]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 15:40:42 +0000
From: "Weber, Thomas" <Thomas.Weber@corscience.com>
To: "linux-arm-kernel@lists.infraded.org"
 <linux-arm-kernel@lists.infraded.org>, "ludovic.desroches@microchip.com"
 <ludovic.desroches@microchip.com>, "dmaengine@vger.kernel.org"
 <dmaengine@vger.kernel.org>, "aubin.constans@microchip.com"
 <aubin.constans@microchip.com>
Subject: SAMA5D3 MCI Kernel Oops
Thread-Topic: SAMA5D3 MCI Kernel Oops
Thread-Index: Adxa+7PHavKw0Q6+Ti2yXbNQrjaDxw==
Date: Fri, 21 Nov 2025 15:40:42 +0000
Message-ID: <FR2PPF3F1788DC961C3EC33862EF9FAF76BFAD5A@FR2PPF3F1788DC9.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corscience.com;
x-ms-traffictypediagnostic:
	FR2PPF3F1788DC9:EE_|FRYP281MB3034:EE_|DU6PEPF0000B61C:EE_|FR6P281MB3790:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e9f92ad-1e02-40d1-e581-08de29145711
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?h4COEx8offBW/Clm0AxG9Dm3FncAI4RojXaoVIYFVDvVDfgtC1ISInbzIXP9?=
 =?us-ascii?Q?f0JojbBCBAM+Dx/24X8RSEpdXX8fOl9AUXrFob7xRuMTSycOIJ7tzF/ZSKa8?=
 =?us-ascii?Q?8LDmdY3En3zGYQlRMfL7AKFwsYaxek+KpkLOxaP4mm5GjPODbzmWDcTYY56X?=
 =?us-ascii?Q?J/xTKkNNH7H3mDK5f0zlVtYuG96JdA09bGzKaKtihCC2UNVrAhSFvSgMqVRA?=
 =?us-ascii?Q?oOo/2YyqeGtlIvLVCxY+g/z6qnsDx3OEhQVJIMUMNVsYCk9ixT4wuceyHnpD?=
 =?us-ascii?Q?nqcerYG+FZvvWTWNAuphvGXPZUEWEUNVWFAvI00NBUbU2zz+oFu+WUAji0jx?=
 =?us-ascii?Q?76zueO1/werzfBYWXC6emuoKOB+xQa+0sqCu2Pj64828o8NiinW5paeJXd1a?=
 =?us-ascii?Q?XhXYm22EO48AYvheq4qqt+t2EO1brg1z15qbjZl5m0t0QCFIkA8XQZNfulnZ?=
 =?us-ascii?Q?pMcGNyUv/R3e6+BcDX3qsxePqaNlXUJ/q1FioKDYXOl2F/yivt3n1xAObcxY?=
 =?us-ascii?Q?NNd21MT0j0ay6mWHCKtvI/95R9DqPZzGz7Txx1YnlljogmzpDYEYy06kNlf4?=
 =?us-ascii?Q?/42+HGNPns6wlVmaxaZLY+By9t/e3R1Vi42p7BsMywoZgoEhYyI4BVvyc4tg?=
 =?us-ascii?Q?wIhBWnu0wtK+VKwaeq2LxEKvWRiZZQ+W4VRWMSYMl0NGOdvIkAbmmjaPAf4/?=
 =?us-ascii?Q?/Sr4lGIKeVkIVyWfR1H+1NUETyXMIYSUtU1q2yegWsuvawCpLjMi3O3l/+Kl?=
 =?us-ascii?Q?JTu1xKeqpZZkT/yh7KNcSH//MpPNXxU0XkI5/0nxUqWT/dE+E/wBUxV9ib5N?=
 =?us-ascii?Q?IINpoxo0iS0aVeFWWXTBh05tsOvqE6c504IwpLu/cKcEt/fnJ8M4SJ8FvsnE?=
 =?us-ascii?Q?xVXhjAKyWmlWDNV2NU8u7lkwZjqLpAD2BlFMVnNSK9IJnumC6GCuMAhlnG6r?=
 =?us-ascii?Q?qNDIObP6BsazIt1liyz+VBng2yXh1LaZflef/oytJTEOe4vnKhwgcbqtDCS3?=
 =?us-ascii?Q?Wds6K99HWpuSsn+d8lPEt0x7gikSNUSrL55zamEHhpqDTeh9MlT3/aBdmoa3?=
 =?us-ascii?Q?JxjnfGaZSu9TLiQZ5S1enHWzmPtTr0BR5Hz9FMpS7d7mhJ1UDSEEbbimbvQ3?=
 =?us-ascii?Q?GnTIH4Q5BdnWx0hcg+Cra9jaFIknbqiHkLgkE6PhtAs7W9O+C0N6IRFeUx7q?=
 =?us-ascii?Q?OIoNQZ8pI/6zTZpLOVw4IA6XSyjEb2mS/wa2x3C+u/PV7k60qcmK6jsbMW2H?=
 =?us-ascii?Q?WqiI/65gHI+14vXmHGoftEZSiU1LG9L75M4pyLpOkNCN5BW8Znk0f6if6VdD?=
 =?us-ascii?Q?qB8FD4QT5JDv4pkrDMGc89dA/Nl+7XbW+KRIhohzsRHnNC+da9bfuHoJlPzs?=
 =?us-ascii?Q?007WK5MERYA0FayfE/SD6wzppfdTGO0rbQp1OEVLUIYDbvb2MP8ey06i1jT0?=
 =?us-ascii?Q?+K0nc/pfoRP/ZN+xVN6RasKrMtpi4dX4mchiUymYhEe6X8y7wahX+Q9uFt0K?=
 =?us-ascii?Q?b1dBaMuDVL9BrVY+jI8rsPmPzT+/8RyktegX?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:FR2PPF3F1788DC9.DEUP281.PROD.OUTLOOK.COM;
 PTR:; CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700021);
 DIR:OUT; SFP:1102; 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB3034
X-Sophos-Email: [eu-central-1] Antispam-Engine: 6.0.3,
 AntispamData: 2025.11.21.145719
X-LASED-SpamProbability: 0.083173
X-LASED-Hits: ARCAUTH_PASSED 0.000000, BODY_SIZE_10000_PLUS 0.000000,
 CTE_QUOTED_PRINTABLE 0.000000, DKIM_ALIGNS 0.000000, DKIM_SIGNATURE 0.000000,
 ECARD_WORD 0.000000, HTML_00_01 0.050000, HTML_00_10 0.050000,
 IMP_FROM_NOTSELF 0.000000, MULTIPLE_RCPTS 0.100000, NO_CTA_URI_FOUND 0.000000,
 NO_FUR_HEADER 0.000000, NO_URI_FOUND 0.000000, NO_URI_HTTPS 0.000000,
 OUTBOUND 0.000000, OUTBOUND_SOPHOS 0.000000, TO_NAME_IS_ADDY 0.000000,
 __ARCAUTH_DKIM_PASSED 0.000000, __ARCAUTH_DMARC_PASSED 0.000000,
 __ARCAUTH_PASSED 0.000000, __ARC_SEAL_MICROSOFT 0.000000,
 __ARC_SIGNATURE_MICROSOFT 0.000000, __BODY_NO_MAILTO 0.000000,
 __BULK_NEGATE 0.000000, __CT 0.000000, __CTE 0.000000,
 __CTYPE_CHARSET_QUOTED 0.000000, __CT_TEXT_PLAIN 0.000000,
 __DKIM_ALIGNS_1 0.000000, __DKIM_ALIGNS_2 0.000000, __DQ_NEG_DOMAIN 0.000000,
 __DQ_NEG_HEUR 0.000000, __DQ_NEG_IP 0.000000, __FRAUD_MONEY_BIG_COIN 0.000000,
 __FRAUD_MONEY_BIG_COIN_DIG 0.000000, __FROM_DOMAIN_NOT_IN_BODY 0.000000,
 __FROM_NAME_NOT_IN_BODY 0.000000, __FUR_RDNS_SOPHOS 0.000000,
 __HAS_FROM 0.000000, __HAS_MSGID 0.000000, __HAS_X_FF_ASR 0.000000,
 __HAS_X_FF_ASR_CAT 0.000000, __HAS_X_FF_ASR_SFV 0.000000,
 __IMP_FROM_MY_ORG 0.000000, __IMP_FROM_NOTSELF_MULTI 0.000000,
 __JSON_HAS_SCHEMA_VERSION 0.000000, __JSON_HAS_TENANT_DOMAINS 0.000000,
 __JSON_HAS_TENANT_ID 0.000000, __JSON_HAS_TENANT_SCHEMA_VERSION 0.000000,
 __JSON_HAS_TENANT_VIPS 0.000000, __JSON_HAS_TRACKING_ID 0.000000,
 __MIME_BOUND_CHARSET 0.000000, __MIME_TEXT_ONLY 0.000000,
 __MIME_TEXT_P 0.000000, __MIME_TEXT_P1 0.000000, __MIME_VERSION 0.000000,
 __MSGID_32_64_CAPS 0.000000, __MULTIPLE_RCPTS_TO_X2 0.000000,
 __MULTIPLE_RCPTS_TO_X5 0.000000, __NO_HTML_TAG_RAW 0.000000,
 __OUTBOUND_SOPHOS_FUR 0.000000, __OUTBOUND_SOPHOS_FUR_IP 0.000000,
 __OUTBOUND_SOPHOS_FUR_RDNS 0.000000, __PRODUCT_TYPE_MAILFLOW 0.000000,
 __SANE_MSGID 0.000000, __SCAN_D_NEG2 0.000000, __SCAN_D_NEG_HEUR2 0.000000,
 __STOCK_PHRASE_24 0.000000, __SUBJ_ALPHA_END 0.000000,
 __TO_MALFORMED_2 0.000000, __TO_NAME 0.000000, __TO_NO_NAME 0.000000,
 __URI_NO_MAILTO 0.000000, __X_FF_ASR_SCL_NSP 0.000000,
 __X_FF_ASR_SFV_NSPM 0.000000
X-LASED-Impersonation: False
X-LASED-Spam: NonSpam
X-Sophos-Mailflow-Processing-Id: 35ffce3d084849eca0098a8fd119f095
X-Sophos-MH-Mail-Info-Key: NGRDZlo2MXNEYnoyMXdDLTE3Mi4yMC4xLjIwNA==
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000B61C.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d32e8f01-f463-4612-9c10-08de29145490
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026|35042699022|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XbJ+tb8tAfiJM/iKON2Kn3PyGoVdVpEeRf/eEwdxwV1Ah3vjwuquIqiAVNK4?=
 =?us-ascii?Q?oLqiDM6r9QWY1ci5vTVhU/8zwehdMsxmFcQlB7eMPQPCA6TdPBh0/GHwH90H?=
 =?us-ascii?Q?6EkHTuCt6f8Z7X4+uqbzexER0Mivw/FoNJuJlhJn3PhbvONTBXn51XNq84We?=
 =?us-ascii?Q?lV/feadZnLaFcN3bxuCNXnxB3HZ9/jcKXJG9TNciYKb2+KYs1eIMKDK+xQ6q?=
 =?us-ascii?Q?9FJuPLF47YxDPx4l/rW3M1gipTYvjcldZOEEMUJf6ODs7IorNt6NTdnCEc+v?=
 =?us-ascii?Q?7GusjEa1F1lT+s9XrAMG3/XM7EtAJHScdfRvWLvYGPj3vsCEnm5uGLXCBFvt?=
 =?us-ascii?Q?0ClSWGUA5vaRuyaFv1dE8lezRysRNbEqXAXjQX1VawGYSGMs/xuMx6fE5Wqx?=
 =?us-ascii?Q?3vzQzVInSvKkMZP2o/Kyf2EQMqB+PgdK0rtZI/ylXoGAjAYmxLk+BGiIpYBs?=
 =?us-ascii?Q?n2Y281FEC3hcin8QjmFaYuzMzeq8Qp2a6rymvCM2mfuzXuhub0WkN32tO/Fi?=
 =?us-ascii?Q?btwhnNTFol+1sue3ph4KWdwtNJwEv0HNstkiSY6g4K0EcnqqnpIYN6PRpapb?=
 =?us-ascii?Q?ySUd9rmlPX1JwDg+WR6O8if7cgdl6izQEsvyyEDPbTanfGO1adMhHYreJfvK?=
 =?us-ascii?Q?kdNMLu16PE8UhYwbBP/JM+k/RtL5PPAmI38oDqNJKyUkAeunrBMzQynZJ3cf?=
 =?us-ascii?Q?Y+KmvRfsDeJXN/P/ywwKVdCaiepbT4U6qUc+fK27D92ZNq+av1JKKpTGepMP?=
 =?us-ascii?Q?h8SiTmDo4zNUnpMNsLUSOYTlgxb+4BSM5ss35LZpOsaI6eZlBODf3ZI/jR+g?=
 =?us-ascii?Q?IVunIX72MXAxPlAPnfEW6+2XluPumAbXEZgJxGA0lx+TN4FA7ldVxFxNxyk9?=
 =?us-ascii?Q?1cqYIRygf9X1C0Jz+RAJXaRNPpXGhAeXL7P8ta6zWYgqFuVKzmBzDhotOP8b?=
 =?us-ascii?Q?OtDO3YeNkTSFakIG6sc6iSCYH30BstIWgGoFaCVLyMEGHzz5nG8wPCke1RBC?=
 =?us-ascii?Q?O2EfAKFr/58P/j3R2WFI27Jq2BWV0o9Cm7RJu+aCbDA9ScN+jlW15K9dbKnp?=
 =?us-ascii?Q?veWPiUo3Y93gircUfkUSUz1l2GjvT+B6nkmZhdsDRD/JFK9UUTlZYTwf+X5l?=
 =?us-ascii?Q?/C5Pxaup/V8HXdfWboxbO9D3PWNqoNVdCHAmklfqx5DazMAkHP7SRrLGPlLe?=
 =?us-ascii?Q?XU9/wysUI4QMHg0fGXQynbAc1Zka4/+PdxgRFqjZ6e9SMynCxE8UTtNSGd/G?=
 =?us-ascii?Q?TUkU2Pt38fgWmIbl12QDSkhyehYQ6fSsvJVXYC9hRC0V8h85gOxn3FaIGLPY?=
 =?us-ascii?Q?v3Jxeyd9KCf87Jdn4pMaP24GUME0dQJzeQOdQZR0Z97LGMzoWx5hoWgRTd36?=
 =?us-ascii?Q?yXtQ2p7xf7gjRDJK5O5SZuSn4sX75DGmAL0xteg+eze11y2T8cXTV0heEvL5?=
 =?us-ascii?Q?e0hkHT2cdy/S0fnDDC7nf33HOJvhm+m8hb3jhgzQic5afzx4KE620p4kGhTu?=
 =?us-ascii?Q?guTL/4Un28U5iSRuhfZH0HqaZmPb9ybPSa4yBMqAisdzx4cW899Kasg6Brv1?=
 =?us-ascii?Q?+a90BNQCGL7QDq5dgxg=3D?=
X-Forefront-Antispam-Report:
	CIP:94.140.18.226;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mfod-euc1.prod.hydra.sophos.com;PTR:mfod-euc1.prod.hydra.sophos.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(35042699022)(14060799003);DIR:OUT;SFP:1102;
X-OriginatorOrg: corscience.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 15:40:46.8970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e9f92ad-1e02-40d1-e581-08de29145711
X-MS-Exchange-CrossTenant-Id: 6fa424d4-13d6-40c4-a9ea-681919dc6b2f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=6fa424d4-13d6-40c4-a9ea-681919dc6b2f;Ip=[94.140.18.226];Helo=[mfod-euc1.prod.hydra.sophos.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B61C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR6P281MB3790

I update a 4.4 kernel to 6.17 for a board with SAMA5D3 controller.

When not using DMA, the MCI cannot find the inserted MMC card. Now with act=
ivated HDMAC I get a kernel oops.


Can someone point me into the right direction?
Is something in the gpio configuration wrong?


Kind regards
Thomas


[    1.145000][   T12] 8<--- cut here ---
[    1.147000][   T24] 8<--- cut here ---
[    1.150000][   T12] Unable to handle kernel NULL pointer dereference at =
virtual address 00000000 when read
[    1.153000][   T24] Unable to handle kernel NULL pointer dereference at =
virtual address 00000000 when read
[    1.155000][   T12] [00000000] *pgd=3D00000000
[    1.156000][   T24] [00000000] *pgd=3D00000000
[    1.157000][    T1] at_hdmac ffffe800.dma-controller: private_candidate:=
 dma1chan2 busy
[    1.158000][   T12] Internal error: Oops: 5 [#1] ARM
[    1.158000][   T12] Modules linked in:
[    1.158000][   T12] CPU: 0 UID: 0 PID: 12 Comm: kworker/u4:0 Not tainted=
 6.17.0+ #11 PREEMPT
[    1.158000][   T12] Hardware name: Atmel SAMA5
[    1.158000][   T12] Workqueue: async async_run_entry_fn
[    1.158000][   T12] PC is at desc_to_gpio+0x0/0x24
[    1.158000][   T12] LR is at atmci_init_slot+0x70/0x398
[    1.158000][   T12] pc : [<c03bbfac>]    lr : [<c0585d4c>]    psr: a0000=
113
[    1.158000][   T12] sp : c8841e20  ip : 0000006f  fp : c095b21c
[    1.158000][   T12] r10: 00000000  r9 : 00000000  r8 : c17a2780
[    1.158000][   T12] r7 : c17a2408  r6 : c17a5b0c  r5 : c17a5a40  r4 : c1=
7a2400
[    1.158000][   T12] r3 : 00000004  r2 : c1461740  r1 : c17a9d00  r0 : 00=
000000
[    1.158000][   T12] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM =
 Segment none
[    1.158000][   T12] Control: 10c53c7d  Table: 20004059  DAC: 00000051
[    1.158000][   T12] Register r0 information: NULL pointer
[    1.158000][   T12] Register r1 information: slab kmalloc-128 start c17a=
9d00 pointer offset 0 size 128
[    1.158000][   T12] Register r2 information: slab task_struct start c146=
1740 pointer offset 0 size 1984
[    1.158000][   T12] Register r3 information: non-paged memory
[    1.158000][   T12] Register r4 information: slab kmalloc-1k start c17a2=
400 pointer offset 0 size 1024
[    1.158000][   T12] Register r5 information: slab kmalloc-512 start c17a=
5a00 pointer offset 64 size 512
[    1.158000][   T12] Register r6 information: slab kmalloc-512 start c17a=
5a00 pointer offset 268 size 512
[    1.158000][   T12] Register r7 information: slab kmalloc-1k start c17a2=
400 pointer offset 8 size 1024
[    1.158000][   T12] Register r8 information: slab kmalloc-1k start c17a2=
400 pointer offset 896 size 1024
[    1.158000][   T12] Register r9 information: NULL pointer
[    1.158000][   T12] Register r10 information: NULL pointer
[    1.158000][   T12] Register r11 information: non-slab/vmalloc memory
[    1.158000][   T12] Register r12 information: non-paged memory
[    1.158000][   T12] Process kworker/u4:0 (pid: 12, stack limit =3D 0x4b5=
d41f4)
[    1.158000][   T12] Stack: (0xc8841e20 to 0xc8842000)
[    1.158000][   T12] 1e20: c1523e00 c0c1b548 c0c1b540 c018756c c14e6e10 0=
0000004 60000113 c17a5a40
[    1.158000][   T12] 1e40: c14e6e10 c14e6ee4 00000000 00000027 c1532ae0 0=
0000000 00000004 c05865a4
[    1.158000][   T12] 1e60: 00000100 c17a5a40 00000000 c17a5ae0 00000000 8=
31212e8 c09705af c14e6e10
[    1.158000][   T12] 1e80: c0c2f67c c0c2f67c 00000000 00000000 c0c3a7f0 c=
144e305 61c88647 c04702c8
[    1.158000][   T12] 1ea0: 00000000 c14e6e10 c0c2f67c c046e534 c14e6e10 c=
0c2f67c c14e6e10 00000000
[    1.158000][   T12] 1ec0: 00000000 c046e804 c0c2f67c c14e6e10 c0c52c74 c=
144e300 c14e6e10 00000000
[    1.158000][   T12] 1ee0: 00000000 c144e305 61c88647 c046e8a4 c14e6e10 c=
144e300 c17aa400 00000000
[    1.158000][   T12] 1f00: c17aa410 c046eb00 c17aa410 c01433e4 c143ae00 c=
144e300 c1461740 00000000
[    1.158000][   T12] 1f20: c17aa410 c013911c 00000002 831212e8 c1461740 c=
1461740 c1461740 c140621c
[    1.158000][   T12] 1f40: c1406200 c143ae00 c1461740 c140621c c1406200 c=
143ae2c c1406258 c0c196a0
[    1.158000][   T12] 1f60: 00000000 c013975c c1461740 c143af00 c143b080 0=
0000001 c0139574 c143ae00
[    1.158000][   T12] 1f80: 00000000 c01405ec c143b080 831212e8 c143b080 c=
0140420 00000000 00000000
[    1.158000][   T12] 1fa0: 00000000 00000000 00000000 c010014c 00000000 0=
0000000 00000000 00000000
[    1.158000][   T12] 1fc0: 00000000 00000000 00000000 00000000 00000000 0=
0000000 00000000 00000000
[    1.158000][   T12] 1fe0: 00000000 00000000 00000000 00000000 00000013 0=
0000000 00000000 00000000
[    1.158000][   T12] Call trace:
[    1.158000][   T12]  desc_to_gpio from atmci_init_slot+0x70/0x398
[    1.158000][   T12]  atmci_init_slot from atmci_probe+0x530/0x758
[    1.158000][   T12]  atmci_probe from platform_probe+0x58/0x90
[    1.158000][   T12]  platform_probe from really_probe+0x128/0x28c
[    1.158000][   T12]  really_probe from __driver_probe_device+0x16c/0x190
[    1.158000][   T12]  __driver_probe_device from driver_probe_device+0x2c=
/0xa8
[    1.158000][   T12]  driver_probe_device from __driver_attach_async_help=
er+0x28/0x40
[    1.158000][   T12]  __driver_attach_async_helper from async_run_entry_f=
n+0x20/0xd0
[    1.158000][   T12]  async_run_entry_fn from process_scheduled_works+0x1=
a4/0x27c
[    1.158000][   T12]  process_scheduled_works from worker_thread+0x1e8/0x=
25c
[    1.158000][   T12]  worker_thread from kthread+0x1cc/0x1e0
[    1.158000][   T12]  kthread from ret_from_fork+0x14/0x28
[    1.158000][   T12] Exception stack(0xc8841fb0 to 0xc8841ff8)
[    1.158000][   T12] 1fa0:                                     00000000 0=
0000000 00000000 00000000
[    1.158000][   T12] 1fc0: 00000000 00000000 00000000 00000000 00000000 0=
0000000 00000000 00000000
[    1.158000][   T12] 1fe0: 00000000 00000000 00000000 00000000 00000013 0=
0000000
[    1.158000][   T12] Code: e0200193 e12fff1e e3e00015 e12fff1e (e5902000)
[    1.160000][   T12] ---[ end trace 0000000000000000 ]---
[    1.161000][   T24] Internal error: Oops: 5 [#2] ARM
[    1.161000][   T24] Modules linked in:
[    1.161000][   T24] CPU: 0 UID: 0 PID: 24 Comm: kworker/u4:1 Tainted: G =
     D             6.17.0+ #11 PREEMPT
[    1.161000][   T24] Tainted: [D]=3DDIE
[    1.161000][   T24] Hardware name: Atmel SAMA5
[    1.161000][   T24] Workqueue: async async_run_entry_fn
[    1.161000][   T24] PC is at desc_to_gpio+0x0/0x24
[    1.161000][   T24] LR is at atmci_init_slot+0x70/0x398
[    1.161000][   T24] pc : [<c03bbfac>]    lr : [<c0585d4c>]    psr: a0000=
113
[    1.161000][   T24] sp : c88f1e20  ip : 0000006f  fp : c095b21c
[    1.161000][   T24] r10: 00000000  r9 : 00000000  r8 : c17a2b80
[    1.161000][   T24] r7 : c17a2808  r6 : c17a590c  r5 : c17a5840  r4 : c1=
7a2800
[    1.161000][   T24] r3 : 00000004  r2 : c146f640  r1 : c17a9f00  r0 : 00=
000000
[    1.161000][   T24] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM =
 Segment none
[    1.161000][   T24] Control: 10c53c7d  Table: 20004059  DAC: 00000051
[    1.161000][   T24] Register r0 information: NULL pointer
[    1.161000][   T24] Register r1 information: slab kmalloc-128 start c17a=
9f00 pointer offset 0 size 128
[    1.161000][   T24] Register r2 information: slab task_struct start c146=
f640 pointer offset 0 size 1984
[    1.161000][   T24] Register r3 information: non-paged memory
[    1.161000][   T24] Register r4 information: slab kmalloc-1k start c17a2=
800 pointer offset 0 size 1024
[    1.161000][   T24] Register r5 information: slab kmalloc-512 start c17a=
5800 pointer offset 64 size 512
[    1.161000][   T24] Register r6 information: slab kmalloc-512 start c17a=
5800 pointer offset 268 size 512
[    1.161000][   T24] Register r7 information: slab kmalloc-1k start c17a2=
800 pointer offset 8 size 1024
[    1.161000][   T24] Register r8 information: slab kmalloc-1k start c17a2=
800 pointer offset 896 size 1024
[    1.161000][   T24] Register r9 information: NULL pointer
[    1.161000][   T24] Register r10 information: NULL pointer
[    1.161000][   T24] Register r11 information: non-slab/vmalloc memory
[    1.161000][   T24] Register r12 information: non-paged memory
[    1.161000][   T24] Process kworker/u4:1 (pid: 24, stack limit =3D 0xda5=
9f543)
[    1.161000][   T24] Stack: (0xc88f1e20 to 0xc88f2000)
[    1.161000][   T24] 1e20: c1527000 c0c1b548 c0c1b540 c018756c c14dae10 0=
0000004 60000113 c17a5840
[    1.161000][   T24] 1e40: c14dae10 c14daee4 00000000 00000026 c1532138 0=
0000000 00000004 c05865a4
[    1.161000][   T24] 1e60: 00000100 c17a5840 00000000 c17a58e0 00000000 0=
958cf9f c09705af c14dae10
[    1.161000][   T24] 1e80: c0c2f67c c0c2f67c 00000000 00000000 c0c3a7f0 c=
144e305 61c88647 c04702c8
[    1.161000][   T24] 1ea0: 00000000 c14dae10 c0c2f67c c046e534 c14dae10 c=
0c2f67c c14dae10 00000000
[    1.161000][   T24] 1ec0: 00000000 c046e804 c0c2f67c c14dae10 c0c52c74 c=
144e300 c14dae10 00000000
[    1.161000][   T24] 1ee0: 00000000 c144e305 61c88647 c046e8a4 c14dae10 c=
144e300 c1795c00 00000000
[    1.161000][   T24] 1f00: c1795c10 c046eb00 c1795c10 c01433e4 c158e300 c=
144e300 c146f640 00000000
[    1.161000][   T24] 1f20: c1795c10 c013911c 00000002 0958cf9f c146f640 c=
146f640 c146f640 c140621c
[    1.161000][   T24] 1f40: c1406200 c158e300 c146f640 c140621c c1406200 c=
158e32c c1406258 c0c196a0
[    1.161000][   T24] 1f60: 00000000 c013975c c146f640 c158e400 c1591540 0=
0000001 c0139574 c158e300
[    1.161000][   T24] 1f80: 00000000 c01405ec c1591540 0958cf9f c1591540 c=
0140420 00000000 00000000
[    1.161000][   T24] 1fa0: 00000000 00000000 00000000 c010014c 00000000 0=
0000000 00000000 00000000
[    1.161000][   T24] 1fc0: 00000000 00000000 00000000 00000000 00000000 0=
0000000 00000000 00000000
[    1.161000][   T24] 1fe0: 00000000 00000000 00000000 00000000 00000013 0=
0000000 00000000 00000000
[    1.161000][   T24] Call trace:
[    1.161000][   T24]  desc_to_gpio from atmci_init_slot+0x70/0x398
[    1.161000][   T24]  atmci_init_slot from atmci_probe+0x530/0x758
[    1.161000][   T24]  atmci_probe from platform_probe+0x58/0x90
[    1.161000][   T24]  platform_probe from really_probe+0x128/0x28c
[    1.161000][   T24]  really_probe from __driver_probe_device+0x16c/0x190
[    1.161000][   T24]  __driver_probe_device from driver_probe_device+0x2c=
/0xa8
[    1.161000][   T24]  driver_probe_device from __driver_attach_async_help=
er+0x28/0x40
[    1.161000][   T24]  __driver_attach_async_helper from async_run_entry_f=
n+0x20/0xd0
[    1.161000][   T24]  async_run_entry_fn from process_scheduled_works+0x1=
a4/0x27c
[    1.161000][   T24]  process_scheduled_works from worker_thread+0x1e8/0x=
25c
[    1.161000][   T24]  worker_thread from kthread+0x1cc/0x1e0
[    1.161000][   T24]  kthread from ret_from_fork+0x14/0x28
[    1.161000][   T24] Exception stack(0xc88f1fb0 to 0xc88f1ff8)
[    1.161000][   T24] 1fa0:                                     00000000 0=
0000000 00000000 00000000
[    1.161000][   T24] 1fc0: 00000000 00000000 00000000 00000000 00000000 0=
0000000 00000000 00000000
[    1.161000][   T24] 1fe0: 00000000 00000000 00000000 00000000 00000013 0=
0000000
[    1.161000][   T24] Code: e0200193 e12fff1e e3e00015 e12fff1e (e5902000)
[    1.162000][   T24] ---[ end trace 0000000000000000 ]---

