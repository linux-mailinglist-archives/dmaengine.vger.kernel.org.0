Return-Path: <dmaengine+bounces-8725-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iB0/Ec1fg2mJlQMAu9opvQ
	(envelope-from <dmaengine+bounces-8725-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 16:03:41 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A607E7D33
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 16:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0608A312E11C
	for <lists+dmaengine@lfdr.de>; Wed,  4 Feb 2026 14:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3FE42189B;
	Wed,  4 Feb 2026 14:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="rLXtzWX3"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020123.outbound.protection.outlook.com [52.101.229.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0714741B376;
	Wed,  4 Feb 2026 14:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216894; cv=fail; b=l4Mlw47gMYLIBQyLk+HJLU9LnB3qdSqRVuMQZlFKK1lbdblSG4+Zoat0JCOxzOouv65Yy4O0aIgnkpVNKY9Uw4MCg2knP06B7oqWAZpbOG2GCEb0niqV8Z69SRpPeI7RMO28lvYDjUFxDKik6ZFcHuDwPuZgZBeE3iQVZLD2LqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216894; c=relaxed/simple;
	bh=24TBQvpQuE6CDnjSTvZTMz4pGKST31AB74q2diFv33A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UdV/nlhUcmwXdzgDmCpSuXvqLCC6sO76xSLjYIv5Mc1uNN1ZpA68CPpeCzqtT6NtKpkIw747PYF7WCtj02fvSIqRXJUs0WAcqbZzBPMjqDmqymukNb7CLuNEQLI14xLUaCQZ99CiLoPesOq9DhPhJ9rbd4v7keH0p3GPGMOz9zk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=rLXtzWX3; arc=fail smtp.client-ip=52.101.229.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kekdin/5REI4L96eNT5BnP4KSsjuH8AoXiLnExyYv6wKXxgV8LPrmOSy6MeGH84OdzAYpLLMLqWF2qKvD2xdlt/0giPaWsVpXe94prWH+RhzVlyqJuaF9/cUoogm2FT9vWFqDFQ/bZSpJlIRKzfJc0nar8x9X95633GiQFMFAn1qof258dtFRSfEngDySk219AYqt2i2inOH5iMbdz7pun3EjuZ/hyK775w16Xc9hJn7J/ODf67GtgJP3y1wqCtAPHEcFPme5e0XWFUDFf5tfko+Jvg2J8BQSg2KKudlDm9Ecdq+u1cAxgnEP4fXq1ceAqd3fGh22OF0sKYTbx18NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sjc2bIUjZx4Lq+ZCVMTvs4e3zQrlPVtxbX6LK1KMu7w=;
 b=oEPpH4Jw4YUxZzxKKKvDsB8CMSoHouLQMYXU183IN6B3VS9d64iddUWUn1wAOjlBSRoYqoE098v4sk0u/312lEohXUJZjaSrMALNzRkoRtGUHIswe7YBwzDUuNSu1iP/+9dLpF+jpaKBJLcBThZzWr6+z9917wwYxvvain91vrKAX/57VSJxOo90ioZL01aOaWesAeRZXkgDoYpw37porU20TogQt5ZMbr/EQuLl8DJlAcP4V78UMBcEIHhP1lzt6RsgEVAZ1qZL5i/49WLA1XAG40XcdN8j99TV0OrQLMY+fd2rt7hGfdqDBDhc0d0CQxJv8CBcY/AGVH9s3zmC1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sjc2bIUjZx4Lq+ZCVMTvs4e3zQrlPVtxbX6LK1KMu7w=;
 b=rLXtzWX3xu/VXwmf3bcVbpXitbFeP5G5OoT6DvxmP4vfSprH5kkqqbcpgOizkHjxqHNQbl/v3leRIA0N+7/GpY77rCewNYZI7I+7ENC50R8PZn5r0sZo7wT4F7uswWYl4taxiRR6NiBVGxqUP9Gcc+jOpPykF36nfQsNPxSb5nA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB2976.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:302::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 14:54:52 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 14:54:52 +0000
From: Koichiro Den <den@valinux.co.jp>
To: vkoul@kernel.org,
	mani@kernel.org,
	Frank.Li@nxp.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com
Cc: dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/11] PCI: dwc: Record integrated eDMA register window
Date: Wed,  4 Feb 2026 23:54:35 +0900
Message-ID: <20260204145440.950609-8-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260204145440.950609-1-den@valinux.co.jp>
References: <20260204145440.950609-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0024.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB2976:EE_
X-MS-Office365-Filtering-Correlation-Id: 99faf829-342d-4fdc-2ec3-08de63fd5a67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dTzpn7L4vP3GqGU2fceAvX8ZNcrhj5mw+J2OctGZn/jLhY/8rcW38d2sze2h?=
 =?us-ascii?Q?oYzLolitpffUALzXtcvwOjbzru1zm91vd8dQBjgkCxTKaJH+o66FRzu3ekqz?=
 =?us-ascii?Q?R6TvwfR74RsdtDcBtCOBDrvFVArh04rAm3yg3IHKxN5uYe9InoVzs80FJRiy?=
 =?us-ascii?Q?KMy/vytWCr2jaNy6at3gGDQJb6HmYEZkISxfHs49Hgbj2WWMpQ50uiq4T8ON?=
 =?us-ascii?Q?6Kf8fxdD1Hg4NU+3KXjE48X6tPWW2zdWyjXko8vWtbwO1fnaKZ64UuA3agbG?=
 =?us-ascii?Q?GoCwXX+6X6Xn2eaQQyG9XOryDBlWJ8n6v4p4dCehMuTds7BeeOMplEP+gmQc?=
 =?us-ascii?Q?SeUwrTzxtbvk88ruJfaEDlj3BE1IZl2Akz81o13MPaue/D9rdNhE5J9QYLEO?=
 =?us-ascii?Q?pMchDZEyBdkN1WSkQ4bpbD3RnT26q9YiUGFCxJMvX/lEliIBfEiIyYdkWc8d?=
 =?us-ascii?Q?lr9E1OpSc6locLDSRCw6YW/2MXZ2dJW8K+gDg6C3VQMzEmyRMpbYmnSSI6XU?=
 =?us-ascii?Q?m0EWIC68hI18t3g38hpeB7ZP0FUc4TpsJpSzZkx+8TB/qamTTaLUvmMX9r7F?=
 =?us-ascii?Q?rUpsJEw7Q/UWn8awxHR7QhH7x5hkBhrjz0V3PzviPcYyH3Iq+XWky5dfui2D?=
 =?us-ascii?Q?zbM9cAA3sVcBZYGJAAP9sHOq5xpOHzrl63VEnfGv6whb6LFoWbY8we+68N4R?=
 =?us-ascii?Q?HwA7acH0xLYTgL7qAaynVb5q71ZsjvC+ziaffpW62Q4pt4pXkpZsu6euNop7?=
 =?us-ascii?Q?XBnVmGg1PE8s5BZ51NVr5JkJoVtPGLuO6HD7P4EUYY7YLod8qSZZyYEfy6mi?=
 =?us-ascii?Q?t0pNtJwNu8NXSoSJCV/GK+/q+hkSqx8oCylevIqH+xxmVOorukJ3MDHVxxmI?=
 =?us-ascii?Q?2YnK76ejd9OrC8eTyJGMlFLhvfFIIhDANiysGFF2wJcWEhjcHH3A2DLFYA+E?=
 =?us-ascii?Q?QXi9J0aDAqhu+FuE4qA9Zj3WB2sfoHS2AUwXGWaSP7gkiFACbmsMlJuqjU54?=
 =?us-ascii?Q?a8+/Dnk6yL6nMfJcVQ5L9Q+LRyMvkHwcJz+amvVCqcc1NBa1l3NO/L+vj8iC?=
 =?us-ascii?Q?GVD4Jhjir2zAdiRh2Dbl08WlRo7vkMGYnqdDmAe4WLvL+AoLUWGUJzfNBosX?=
 =?us-ascii?Q?ZhtGWCSe/fRZUREU+SStS7MD58/QHGp8V4vBbwKKESTHT2NpffEYd5dgA4Ix?=
 =?us-ascii?Q?MWZKNykgjMQ5fpBKzrBaNBlncUFKjSdVHlNTODyEpFpG0BvinccgGxl/uqmL?=
 =?us-ascii?Q?brlmTvDtsk7FL44IADmQTrE2T2rpG1Qb9F9k1x4oPoRZc9SadtNbsRdIS0Yx?=
 =?us-ascii?Q?kVu/UFqP/u7GTZDRyaKUTplBGpakOmzbRpeabfheFOhiMR1Ou3F+axKPVl/a?=
 =?us-ascii?Q?5bipuNhPiRY7SG4ir9aq8saFRXdw0LexMnxIdNYXTKqqvHhEJRK3VPj6QV7c?=
 =?us-ascii?Q?alMKgxj2Wqqem8KrvciBrfW0/aH6v044UhczlkQzUHM/3K/jZplHtA1NofYU?=
 =?us-ascii?Q?AXTcFK2KfAihmZ1OKrtcrNGZjE0NlQ7TDcw+9ntg42+HDh/WUOsUYCMji266?=
 =?us-ascii?Q?vkii2UGmm1S3dw8hZB0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5Imr2b9aS09g5Ax5ljkxK6iW5meaXgq16zqjW/QA801hKw0XBd39YnE1Jk53?=
 =?us-ascii?Q?BRyJZqGNrQUfnhDL6JglehD9oN9B9vBsIjPO/lPwa2XGZKjR7W4RQJ25so9Z?=
 =?us-ascii?Q?gio8nh/BH+VzjOC1imsgv+OVyU1QtaYGBQSsHcdxnMPOU7X3sJkHQG8hyloL?=
 =?us-ascii?Q?otKSD7IHHXiLK2jYEkgF/ANq7OG6dAFlLvnXl2GynjytIRvFMoF8rvg9mi6H?=
 =?us-ascii?Q?eM0UkZl7M5WCgEBXoevjEA+yKB8AQdhiRw2fUu/e/jG+3uYScd+CUbJJUeFm?=
 =?us-ascii?Q?kCdm7pg78gLAtW20UZ4cSlijtlXpmjnMRb7zMT2c7CWANIzldwaAAmHpCN2k?=
 =?us-ascii?Q?G6pPg+iByIk13DOBs4v3Q04YU8MulYAVYp/wy2AqB0vneoqeiSOlERiUHK0R?=
 =?us-ascii?Q?jb3ci3mg9OL/B1DOmD495QDkzkr439q8El9K3fgOrz7/z9D7jTQtM2dqrx8e?=
 =?us-ascii?Q?7ZmR3eD878Dt6/KeK0Sb4i1oPok/CO3A4il8rHMkaxqX97CyAD3OqnTxtZ33?=
 =?us-ascii?Q?cO8edRor61nL6G/5AwS5uLECreFnnOkxjhRFYnFfMUzsZQ6L2z+oql1qAOzP?=
 =?us-ascii?Q?3mcgVWXLWHi7B0FHQyWDXDclsWqkCKnnVMgl432KIw8Sos87ZVk/pkLGRw6V?=
 =?us-ascii?Q?zm1xWQefHug2MACv6tEYkPRLLwrgCP0mjXNnnTBFVIUDCqp5C/CRhlEzbCoJ?=
 =?us-ascii?Q?muU7uJWFW8TcyT61yVw9RLNu24+ar1gM3KuTKAlK5LUcBKOSm4DqUVmcIePR?=
 =?us-ascii?Q?zv8SHF1F8O1ctvGBrouNZs7vOcNpYeD7GtngC0RShgXJ4zBB7fRT9m7o4Nvc?=
 =?us-ascii?Q?H2URZ1UncjIgo8yUgFdqsHA4MK1JEKvq43EysXS9RmtYfN4DezV8j5hwgC1b?=
 =?us-ascii?Q?hm+8udLJaVGJD1M5DWmPjJEd904leG1WTIM7HYVVVD3geTZy9IrQnG6hbcm8?=
 =?us-ascii?Q?nx1LGNLL0p2BkoTpWwqDzbPcTJx60Jr2eOgTtlSlA04zs/zVCvr5GTJ4R9Sh?=
 =?us-ascii?Q?r73UlXQsgnuB3GrlTT7ds6S/AB/DFcLhblI6e5RM9IHbcbgTdaOZiQVovxXN?=
 =?us-ascii?Q?6Po3YaJxjpg4EuU52j4IdszqB/wgjlzagZVssuQFMyKPPVFWU7zc3WRnwGnV?=
 =?us-ascii?Q?dT1NEBTHt9OS5ayVTSn2HgfAvfKSkznCvHNiza6RL/zL8F2m3Vq+yZ1QCIsr?=
 =?us-ascii?Q?OBVO86RpoR+doQiA+OQE33RVE/2aB7ghYt50ktKTZz1o2agD/bx9jW1i4Kig?=
 =?us-ascii?Q?NSSu66GFbWA4FJA3ePdz5gl1u1CtQZYEXUXO3fd4KZF2Glam6yxbt7OXbzzV?=
 =?us-ascii?Q?TReMfvNSSLTXgYQblC2MD6ogByvov5ojneUxlrWFGIqGok0UckNo5/gwJV7/?=
 =?us-ascii?Q?BUZF3ZFpheRg7u5IrPu7GFvrSJBn9CvnaPMV595nNo+0SRIWbVxNli1ezC7A?=
 =?us-ascii?Q?goQi9j7R4HH2xtM1RCTxeLLbPc6/RxLkaumtv8ffbq2dmGlm21FP9pH57u76?=
 =?us-ascii?Q?KSQdIyjJxfG/1vkvZMPKdaAX+RPNnGuP29n88S7IL+tMD2DF2kUF43LTstX6?=
 =?us-ascii?Q?8ifJrgSpIguQ5JkwLqbqMgQN8+P04/C+rh77AyfkrxoiBGFJg27x+tymB3Q4?=
 =?us-ascii?Q?/YRmKOf3+5fk4T5mp5cDrj51PQgp3vqrQ/Fenul54cWLJTHT3orL6AVr91IF?=
 =?us-ascii?Q?8fQvZ5zbSt8jz5eAZOVqlOeo1He/3v3M61iQnGegnazBqeZr6hz5GheEL72q?=
 =?us-ascii?Q?1DhDbEffDjA4Pz0xnfnyOOkEIdpbwplwx78788UuhzNw03YO/fvM?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 99faf829-342d-4fdc-2ec3-08de63fd5a67
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 14:54:52.8146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w/Mr7WIcdtBfQtMqtPIwsr+WBX1UJO1fNVXLShebky600XTEMUjhKZr51K3c3gLFSZg3wXPiCjHNVhJUU8B55A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2976
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-8725-lists,dmaengine=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,gmail.com,google.com];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,valinux.co.jp:dkim,valinux.co.jp:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9A607E7D33
X-Rspamd-Action: no action

Some DesignWare PCIe controllers integrate an eDMA block whose registers
are located in a dedicated register window. Endpoint function drivers
may need the physical base and size of this window to map/expose it to a
peer.

Record the physical base and size of the integrated eDMA register window
in struct dw_pcie.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/controller/dwc/pcie-designware.c | 4 ++++
 drivers/pci/controller/dwc/pcie-designware.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 18331d9e85be..d97ad9d2aa9b 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -162,8 +162,12 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
 			pci->edma.reg_base = devm_ioremap_resource(pci->dev, res);
 			if (IS_ERR(pci->edma.reg_base))
 				return PTR_ERR(pci->edma.reg_base);
+			pci->edma_reg_phys = res->start;
+			pci->edma_reg_size = resource_size(res);
 		} else if (pci->atu_size >= 2 * DEFAULT_DBI_DMA_OFFSET) {
 			pci->edma.reg_base = pci->atu_base + DEFAULT_DBI_DMA_OFFSET;
+			pci->edma_reg_phys = pci->atu_phys_addr + DEFAULT_DBI_DMA_OFFSET;
+			pci->edma_reg_size = pci->atu_size - DEFAULT_DBI_DMA_OFFSET;
 		}
 	}
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 43d7606bc987..88e4a9e514e8 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -542,6 +542,8 @@ struct dw_pcie {
 	int			max_link_speed;
 	u8			n_fts[2];
 	struct dw_edma_chip	edma;
+	phys_addr_t		edma_reg_phys;
+	resource_size_t		edma_reg_size;
 	bool			l1ss_support;	/* L1 PM Substates support */
 	struct clk_bulk_data	app_clks[DW_PCIE_NUM_APP_CLKS];
 	struct clk_bulk_data	core_clks[DW_PCIE_NUM_CORE_CLKS];
-- 
2.51.0


