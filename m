Return-Path: <dmaengine+bounces-8791-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGGfLrkkhmlSKAQAu9opvQ
	(envelope-from <dmaengine+bounces-8791-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 18:28:25 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 170BA100FA0
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 18:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7C9B30417BA
	for <lists+dmaengine@lfdr.de>; Fri,  6 Feb 2026 17:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5BF421899;
	Fri,  6 Feb 2026 17:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="bbbMZJaQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021088.outbound.protection.outlook.com [40.107.74.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B1441C2ED;
	Fri,  6 Feb 2026 17:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770398820; cv=fail; b=G/2sCg3X56XOwtstSgUYUvD36V64/gCeuMVnCbD3uHEFmiABVfcn5BSi36KnP3mNdnwMz3tulTPhJtDK7o6V3AmsVqrgeZuL7ESvpNoC2NcYmlhN7NeR69mCuZUpTtNWqpuop2tUQBF0Q7U9vtulLO/pA8+EO+kgVde3meBSaT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770398820; c=relaxed/simple;
	bh=fTx60twlm8eOQQ0LDmn/cde81YfV1ISdp2/yz1EnxUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Td1nhcEOJDB5VQk8SIHnTrKE9qQyQRzBN9yOzSSx7BL4wzs0/2ABWyp71imACf9a4iSU81OvTwzRRqOZsgticONXD3nwK76KfAaXtreLPUOIrkwHIJM4psM1k47aDeV1HNYLi20ncss0vyre054zrYoPn9N9/O5tVqBQuFLxkEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=bbbMZJaQ; arc=fail smtp.client-ip=40.107.74.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yVZ2c0TpMW3jVHjGKHdOGOMm88NNRNJ8BQJ9KR7HeEAZ/l2Cyh6nKD/X8ox0jYhEmQcWMf/JmkA/nLwmfRW49aAViRy6s2HkazKNIafQffbO5pEx355v0qhubooDzG4l/iIxIlUJtyHPG3Qv6/FTYh09ceQL5Ugcl3N/SYET3jLne22LjZ5HtmxmOXFWMA0QFl+YhDhxMXMp+G4VCcstEhpCH9mwLd8rCaHr1ycEmsgA2DmGAovuIl3nNwWJ5ITlkr+oKwHNVhPuA49Z8QhWF+u4b6tSfMefEZQvvGXTSVjLEKueuRmN67tkswz5DTxq4noZeklID2fgfBpFXZMc9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8yWAfV8AJ5pPwl+Js3pT03l2aqXPjl9XVUFCNdR+xA=;
 b=uQhmarVL7ZSQsnghaT459fKWnjrW5Fs3g77UxO6YafQjJxHsfHB4afZ1l8By+bl1yaaF4fKsyBKnvNMiX3FSZcQwZIjWTMOT+qf3cHpF1JvuEewrS/6uCmhgdGTD2Ejw1b50jJsOpthf51y+2RwZc9UL8RVEMHUHQ7j8qW0BH/7z+9ZydrGBAa4iEV09wJ+yDe8ZhEVjqCcwCT2eSAblS6sOLPWQ4QpQdNOgNok8F8rVj7iILERdENZ5gFJOT4Oa0+quW6FqpNZ/TKhwfGL90pIIV7kv/fi+PoMZf4NwezsgBQ3aAEuEisKEL4aEqeMsqH/T22FJ0NbUSOs+zfXPHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8yWAfV8AJ5pPwl+Js3pT03l2aqXPjl9XVUFCNdR+xA=;
 b=bbbMZJaQbAHuKMDJe7TAeGlYzQXENX/uTmQWjwzp+j9vtq16pd9Ta+RNRtrV3GsCokrf7cFD55z660JFR/Q4iu6bs7shg4pL75uW4VIktrvS7jid4+exQowy1RKUODzY9dDkwuMMbLhmk3/m1dJW1bGCdCfXDWGycQ1itdva1os=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB5571.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1f1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 17:26:57 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.010; Fri, 6 Feb 2026
 17:26:57 +0000
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
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/9] PCI: dwc: Record integrated eDMA register window
Date: Sat,  7 Feb 2026 02:26:42 +0900
Message-ID: <20260206172646.1556847-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260206172646.1556847-1-den@valinux.co.jp>
References: <20260206172646.1556847-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0048.jpnprd01.prod.outlook.com
 (2603:1096:405:372::13) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB5571:EE_
X-MS-Office365-Filtering-Correlation-Id: 78f095db-32bb-4110-9b24-08de65a4ee04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NU2Nd65nPlf0AdBzolrcZbJscX+aKZPUh2wWSsSMFVe60arrpJYuMuq5tuaR?=
 =?us-ascii?Q?kIcybBsBtwv7EaqDKZ8c8hAA6pOEKexmeWIga2KLDg+7+7sNqE4sESk9CmDh?=
 =?us-ascii?Q?QdeqQs3yWn/Mp8yG1/vcpPlUDNzHJP+EQrgQzMDGMjesOc0CDW8+h/Zv3KAj?=
 =?us-ascii?Q?ZQH6V7b8zPparl4TSn0JH4nPzkvt3pLSQsBifcGzqr0oMr+m1wLra2VYMW6o?=
 =?us-ascii?Q?7A6OVn7FE1ZvsA4yJMTP33prLvhnkW6I+1nFV+jF5Jm+IWUHdeuaqjJJdAeF?=
 =?us-ascii?Q?oXR+OmZnXlTzHznmgmNbjo5I0usc1mTuX18JDY1XwrcsIaRJXaKrRK2Tdc/F?=
 =?us-ascii?Q?rrjJiug3UwdzDlAwBmgj9PexO+BWoihv3IjL/ZDRiBwOLQWova4hEio4SQUU?=
 =?us-ascii?Q?oKII2dHmXrUIAYJ3ruYPOYB+Irm5hQSF7ouGzeCTBSmlJq0T6BltMCA7bDkp?=
 =?us-ascii?Q?jQJ3hqrBdE+fqhLvhzKV+TrSO9st5faBaFMMSeiy4Gp5PvPi3jmbZOWv9cE7?=
 =?us-ascii?Q?HdzYNs1gMeBGtebQAzq5Kjfp6DuiDzqcfX/U9wX6CI1klf5EI8fEqRQTLEjK?=
 =?us-ascii?Q?8TrIIQl4NjrmVoUCwIt3c/YcxPvveYBsWFTsO12dVsvmaXX/et6w70U6DJs8?=
 =?us-ascii?Q?A0zbnTnLthqR2pGSciWvs+8T893pHuaYip5YuvMS3BIn8QTU6AsUISq93rdY?=
 =?us-ascii?Q?i44Cua0U4wQrXFcvZlKtFEpn4YWQDT01k6k2/Mr8yLF5VLOvyl5ewQRgmF7q?=
 =?us-ascii?Q?aH6mbqlOk45kMk9FhrM5DyjqC9mdnRIMDeFNPmng7/DYLGw6c7ccRDaB/nCp?=
 =?us-ascii?Q?PophNwZo28hAbTUk0xG/Ha3NXdcLcDHXqScn04JIHBwQcuRfKU9IEXgoUkkV?=
 =?us-ascii?Q?q7sNHVFHALkbXiQpu4STg/9JGo4ANHCCAqULwiLgHaFx5keRN9hfyySlJQ4r?=
 =?us-ascii?Q?t+tXDO2pT5TXtMEc8tLwLEh5HHC/k+nmwD4i8KrbEqFL7bVJN6GnCXVryijY?=
 =?us-ascii?Q?SqLpEFjmd3BvUy+D5bRQ0bOEs/zWaqepGugOO8lrhYIqNUY0kNhRUUgP6o/E?=
 =?us-ascii?Q?Gx5pny7I/gAmGwubMX3aU7kmZQvGa8/9uoGRhxnZf+oL9swLOgguhu6q6WDJ?=
 =?us-ascii?Q?HsRT8w1N1agd21Y+OswLYquAWogOdE95KAPLMQDfghQHBZqh+sz8M3YY1wWN?=
 =?us-ascii?Q?aoCncZpZtMB/MgX5QpPEUmlBRHpVR7wiBQ95A+AKvhLAjXw5WXzptz+20dTV?=
 =?us-ascii?Q?mCpyikdp5D7ckPAQlnT6AYDu4uH2JlVRefVFhBR9EfmC/L2o0xYwiSOB45r5?=
 =?us-ascii?Q?SyCCfURScOgKbPar3L5itAZkgOH4T8lj6mwIyziBFRP7vcqwz8lLtbZNCI3S?=
 =?us-ascii?Q?/76e1ndhf8fk17jinKvoyxNq1YjDz2MtptuU4SGNEy99O73GaEex3875OHL/?=
 =?us-ascii?Q?oLRjk7awCLKr9dSAIBcy5xLvp272yzPknmUnlq5Km0bliht7gVT5Up35ERg5?=
 =?us-ascii?Q?wNi3osHx3dDlFFdWu+pywQyJxrUDpUlcUqxkl85eXL48GX3Jd/DiqoyynxQK?=
 =?us-ascii?Q?/aiV682fb4475Ir0ayQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g9O37bxtrBVnyFqKQAphKCW/r4neeCJmWnbTYvG2ug0/KQJ2gTUaXwTCU2J1?=
 =?us-ascii?Q?55gCfURaQgEwVl2lJLADrG5X0Fe2pAnoIx6XNWrYPPH/6UVJeWbUR+rVLqm0?=
 =?us-ascii?Q?atJiejGKwIK3bK6k03C0O6eDeF9SJr+bAGOq10Nb+PwgE7gmefHCPXsC7IXc?=
 =?us-ascii?Q?KNC0KVuzzOjVeZm/b7oqMeH6/8ClRc/W5zGpLpFCBZW25dhk44I+U8aVmJm8?=
 =?us-ascii?Q?1CVCjkcEPB6DdRHGYY5KrNg3u2/45jnPEm8hW1ME8G2QnIWITzG2qrrOKAhB?=
 =?us-ascii?Q?19hrSRcNrtWC0v+zVJnYbBfYHiHrSZO4BlyqhPxYwV9Z/r4nyShSnESSFM9J?=
 =?us-ascii?Q?9sJXQ/QfolQnNJgFYFn5Llzix2x2ISCxNk5mj409FefZxmnBO8bRTFTMxR61?=
 =?us-ascii?Q?YtXeE88Np2Pjk5pyMQ1Wwr+XEC7CQ8PtO4ngoKzZsLzVRWfDSf8yQDPDDj6B?=
 =?us-ascii?Q?0rdjcTTXzmm5Vl16V6bpDOn4/MYOBEdP5fuRSLeQV3jf6xQtUQUHPuV947Wi?=
 =?us-ascii?Q?TlKGfcEP9h1zsim5hB+rFi0T5pAxhN0TgnmW8i1xsPQ+eqsYmKddS6DkEolT?=
 =?us-ascii?Q?gd4LO45ENCy7CTdTUGks/7SG5GmwEcGXkU6VXKo5GbjH8qF4pyIrZKkf9xmw?=
 =?us-ascii?Q?NywRhJR7kYzm6Cc7A+0+VyNXOn0s7/y/pHfT4wQUvbU9MUfdEy9+lsjnJoM8?=
 =?us-ascii?Q?8DT9ZnjNku/hIdqhipAxCPOfzvwIZ988XO+8EJml0WAijqoFZxS0i8HygCX5?=
 =?us-ascii?Q?lLQgOH83I1NAx4P4D+mXrZh6Mkjvja+ysKUdWL2RTkkaGH74YQ4tL3Ru24H+?=
 =?us-ascii?Q?9/Mr9YT3Ja9wtyRVmYwUmdNwvlQnR8NhXwF7gxln+g0/3lJ+gvyRGGO7g55o?=
 =?us-ascii?Q?cXTirnVappvo/vxH/LlkIamncyywtaRIyOniIjItip6GfBVMDkznrVWs0wxp?=
 =?us-ascii?Q?aRqkj0vqQKpujRqkhP6en8yqBNVlxHyEkmhNVWiR7EJkSgiuOU19gMYfJbEX?=
 =?us-ascii?Q?zgPuGzNWESSZ/YIuxR19XR6X8xqtZdhZe7oDcqcTUu3i9fhZ/0B7R/osdWli?=
 =?us-ascii?Q?Gme2GjvbHONKX2T/BZlvRvKJvmCfzYrtOCex/cx5u6jJtS2I/XOorNAJTdcC?=
 =?us-ascii?Q?N2VCcbTZhqMIcU3hYId6NynCnJRFDTT3AMJqV1UpTpRV+w7L6CqrVuq3Igkq?=
 =?us-ascii?Q?qPwW8+V6KbA7YOxt5Jo27lN2098EInc35juTTe7u5GbK3dgiZrwr2bnUkGlc?=
 =?us-ascii?Q?ovcf6WovrlD5QlrYwfiVq0kf2APt84oPThbXOcr/Tlet2RuQIetFR3b0UwEW?=
 =?us-ascii?Q?1dw6AuXUIDclmkSFHcnY6Jk1yZZbMPazMSRlnsOc2Y+oddv6gATfTOMyla6u?=
 =?us-ascii?Q?IXUvfo6uye4RvV0P+AMyrtOFVUKGxzsuo5R7JiQkWs5Lmzf41JUbufIUwtmh?=
 =?us-ascii?Q?02on8rBA3cFWGYlcnDPWxSBVBLaI7hGTZLmT5IInnhi/1YJpakH79x6vfw/G?=
 =?us-ascii?Q?i8KG6EdG6im1sG2xxLB0oDqAgltYID1U1W89Wa6PdfXJ6HQKOkSsxWH8ay28?=
 =?us-ascii?Q?T38tszxfV7HRJpcSMngDN5lGG+zi+mNGgBKMwiO20/1Naj3MWJrjZjyi3MWo?=
 =?us-ascii?Q?Yl4HXZUtI0rXYGe2p11yAwP+J/fn/scjXV6VpL/hug0YKjq6uQ9CV3LyZzHO?=
 =?us-ascii?Q?MxHcUiFMqQfBePOwyXQKTjPNoNECijV9SphsuFQ6F5lVi55XlBLKWj1lI6ur?=
 =?us-ascii?Q?iaX76AJssCiW8QPFZX+PyF9WG/FsXNPXAJLw5FZcQmLwqp2Wozc8?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 78f095db-32bb-4110-9b24-08de65a4ee04
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 17:26:57.5830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wGHxGKC/pApIgjKB0b9lmyICC5w7WaU6Adw0utLT1qG28vge9ONZyw9gLdGCipqRFwTWP05EJx/1OqVpuxJ7lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB5571
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8791-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,gmail.com,google.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 170BA100FA0
X-Rspamd-Action: no action

Some DesignWare PCIe controllers integrate an eDMA block whose registers
are located in a dedicated register window. Endpoint function drivers
may need the physical base and size of this window to map/expose it to a
peer.

Record the physical base and size of the integrated eDMA register window
in struct dw_pcie.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/controller/dwc/pcie-designware.c | 4 ++++
 drivers/pci/controller/dwc/pcie-designware.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 5741c09dde7f..f82ed189f6ae 100644
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


