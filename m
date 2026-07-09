Return-Path: <dmaengine+bounces-12198-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cK1jHR2uT2qmmgIAu9opvQ
	(envelope-from <dmaengine+bounces-12198-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:20:13 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BB873223B
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:20:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=vivo.com header.s=selector2 header.b="kqX/9RFd";
	dmarc=pass (policy=quarantine) header.from=vivo.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12198-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12198-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 88FF931FE540
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 14:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450B7438008;
	Thu,  9 Jul 2026 13:59:50 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012064.outbound.protection.outlook.com [40.107.75.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8492437138;
	Thu,  9 Jul 2026 13:59:48 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605590; cv=fail; b=qtwtXs/OtajHh1dH0YKfLX6LqI7+wB3jebgznDCt4geVpobzVasbIi9HC92rauv0dwbGKDX6bVffezwo4qxtBiyvD0FRfPNStlnC49qYt+G/bO0nGNSVMIehqnA7pPf5/sqfCCLI987M/Pu0Y3O93oY58BIpa56A+HyRkEpzVgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605590; c=relaxed/simple;
	bh=nBJYG+zOabNsW/rGGWdQb09S50TPPRYSsDp6pYT577Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jIocGuCqo9rJs/wSEapMbDtSnzFjniAXbcJRyn0Z4BTTEuxCkQ/H4r2Bvb342ae1d/HRxjUqISWjCx9I4dSZrjMnshD/5IDsIeueF6r5pdUd7tzYZIVMxSu7J6ONiYrzdnroZ5x4fIZaXdzS+3XVhpFvF3OgNc4raMCjaNzjHqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=kqX/9RFd; arc=fail smtp.client-ip=40.107.75.64
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zQhIQNkCFXx4WuRtbHyWqRIuKUQWQZ65tWvcA3iKWj5aWG+YWiR175I+80YrC18oWY9zB9w6QZOn3UoS3dOnYtliwKghuPi2yAU8tm7GbSNuYtX1lBoBJQ9GfUnK1YKF5N5rjQlg+OBOFgukSLZ1WycKgwF7Cb6VVA8sP5RFZQvBTQn0E6IRJ3gVHpEqOaV3UAfMdSBdzi4tmwzcQQrOsSutAnDfvS/LRU8ryH3CDUBGfIsGWXh+YBFvbj0YAwrbegC1KgxLY0xoVOm5QcT6ePOi2aKQH37rsWV392UeLy7rtYyIKvAr2eigSduh2ccpLlRl5CiVdqc3CNWsxV8mKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FtCBv3abBW3JTvmUsjh/D7voc/z903oG9YJf042Vpao=;
 b=oob9KxqCcku0unZobRYLDmnXB7I2EE2HoQNLBwWXFHWsypqdNFq07dGLgBl9tYIrAIVmvCSIVYe0OSvPqFvXf7v9j3Rf6VdsCVpyAwHXDptjPD4+NILnyzW5/jC+AktJAbT+LYq6ZpHIjiZmtwu6u5m0Xbkf1Smy/RDvvuCrl8Q/a5JykI3R0eSAl7G8wyJSdzXggNHr2EjCjWKqYHDpxPYtnC/4VBUHDBI9t6nnAuqmKUZuaqRpL++MChJrjyjBLeJmKRZGoVNA5oPcq+klEUVbD4IXJMrUY7mUVRYnBXPSPL5UkKpOClZUqtwG66/m2SGlM5YAmYy5Xuzj5oarWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FtCBv3abBW3JTvmUsjh/D7voc/z903oG9YJf042Vpao=;
 b=kqX/9RFdkpR5g4MHinsmw9gxI7qEyPhle/EURhLt3ErALg2xy304GqGb0YJfazhZ9a90jkXhf0qHfU2xQc2BLfgv3jkK3l8T24uiZ+YbOzvwxCgCa/SE0P9cbD194onX3MpnV0P3B3e5HwpCgMZ58Ds6M9N6zQUX9j7EG6NmDDWazkKrWhddzGePe5v9zFfTGchHw7PkP0ODUH98guSBb4bUIDDIa7hL+KUcDJwWs+gbkeoEWWWZz7wNBRpejrdNUS8ANCjZE8dW8aTLlxSe4AmafnwzcXO2ak+AXUT3nV0UtBxtbtbXb4xXaEozobkdjDplzKGhH1CD+tKy7k1DIA==
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SE2PPF271E4F3E3.apcprd06.prod.outlook.com (2603:1096:108:1::7c8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Thu, 9 Jul 2026
 13:59:43 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 13:59:43 +0000
From: Pan Chuang <panchuang@vivo.com>
To: =?UTF-8?q?Am=C3=A9lie=20Delaunay?= <amelie.delaunay@foss.st.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	dmaengine@vger.kernel.org (open list:STM32 DMA DRIVERS),
	linux-stm32@st-md-mailman.stormreply.com (moderated list:STM32 DMA DRIVERS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32 ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 20/26] dmaengine: stm32-stm32-mdma: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 21:58:24 +0800
Message-Id: <20260709135846.97972-21-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709135846.97972-1-panchuang@vivo.com>
References: <20260709135846.97972-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0073.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::11) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|SE2PPF271E4F3E3:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aa27fe7-4825-466e-5ead-08deddc253d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|52116014|38350700014|18002099003|11063799006|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	VbViWbDabWj/edDIm/Z9Ji4ZRfMXqPY9mtSAYVzA+9fjuo8CZp5sWqG0LCCpYPQ3zPE7Sb5jsFjul4LyWQtG8e+pfjHVUPNzTGQn25wjkafGaVjSY1xe8Y5m/NgjgNpZYqEYO02AHbEw2yq+MUL/6MmAPW+gc3JMEZfjOXbhweKWJodanI1ZpNAwT7/fFhywpav+j5i1U7Hk3gNQw43SUwS1LL95qEJlJ1utLAy2Q910R7doQ1QBVyrqBERlqSHO0LeM5gHXlh+Gl5MSoWpsXHA4LvSPU6H5PS1rG88jYDjaT9cKXL3Ppibdih1YGrzwaZv0CJQ6VyOpuR3iMaZvrQt5Tk9dQXNlX+4iG9AqXN/imOd3Ml4f4IwLT6Y8vB5jlXW/eXAa7KJkQOnDHECFm3KovaKPW3o3UKipez3f3tr3UQVBorvKEhdMcZpXUU2GWtyGz5i96NqSsM7RbE4foWzWGVuVWAtM8e7DBJ+m9Kbrx6mdqkzs9lE+c/2bS3S1IM1mKTqqu8Wn7tZ7pUIrpKMFy20ZJ9Ec15nZsh23AWmC5Q9TnkSQfPrxkqqGFGkjyYkaqx2rOShkRTnYqPbTojn8Lh7y/1I3EbdYMK3BzTb9itAMQIP5T17wEi4HajGlTUMs8E8f6d7LWG4njK3CmNsSwFDTmp5S+6ajiTZHqtw/hxpbRzLx3oHinFP0UaIigt9t7V1pvNMrTeiL2B0ttPz8lipSLp5YhjWTEq2l8o0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(52116014)(38350700014)(18002099003)(11063799006)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RVmlN/Nk8GcaUlA1n9t8gCuODr1ubOwmo55RHRliatHzlVh8LN6GEghE+6cf?=
 =?us-ascii?Q?Sz7ROG8uXQT0armsl2n3ZotSp7zQFlYZixsYzcIF/+LkTe62NiZKRVrNp5Yv?=
 =?us-ascii?Q?dLoEHXFp83xqlRr0TwpHgfJQ8LHSU7Jg9YkByDuab46+lVoJ8FyXJfiDMBGX?=
 =?us-ascii?Q?oYFK2F8qzrbBoH413Vp6z2EoB1v0PCA+3uT7/0RGUBaqs1fkmDHU5AiCnDrJ?=
 =?us-ascii?Q?DkZqSFESKcdygIzinIUa3eONvhFIi2gsWo78ICQ9BUt4PyfAsJm4GGkWo7u2?=
 =?us-ascii?Q?pcqGYUJkoUxshk9N+zYxjCPwMWU8q8PuDDfN2dVJ2zn4vfBX/GVdM5u6MXD9?=
 =?us-ascii?Q?o0y3MVeTGiSKYfDh2EWIXMatN9SgirSJyRSGRfZaeAZ+5hY7M6W86RM4MAo2?=
 =?us-ascii?Q?byQ+T/nol0zPqiKcnPaApWHCdyH5U/rl5Zfvqhfxdp/9WZSUqF/rB9AMCWB3?=
 =?us-ascii?Q?XdqQpHGfgBDJH7ZBzBCbMsd5eoQSUBqTnT+TSqd6qyIqbE9XJ5KAUf94cUyy?=
 =?us-ascii?Q?UdV4aD39cAGNYchPkt1FteBWAUzo6qdmzGBoQH/8JCPHkUZfkbOmeXOCWwyQ?=
 =?us-ascii?Q?r/5XV7SWMeF7O29sL1O6RXhjmqEqXS9aFK+ACn6vsbrcifAI35m71+X9Dsfj?=
 =?us-ascii?Q?H4pX1LJhVef1B0dNpXxYo6YMQDnwIPLmEyp3T+HQ1qu142w+Wp6MGPsIzxYJ?=
 =?us-ascii?Q?49recqJC0tjsVtJpvKn0aP/dfkroZmgTqzM4EXRmcEgJdAbNo1alW0/Y+RFC?=
 =?us-ascii?Q?leN8fSQSwR0hfyNxd02WXgI+H6WEx21T+UJ3NOU/oWL3O3854VNVW9M1tYQJ?=
 =?us-ascii?Q?926H0sqqU3WeCin3Sg36epmBisXd6jhy/BO0G5apSpYgdPspYUO2IVmfGJ50?=
 =?us-ascii?Q?69dseudMn15VgF4x0JxkFjTbJ17IcaUNsYU5LPF2OYFw/Wv/bTvf0pF5EOkV?=
 =?us-ascii?Q?EAO3BqoUOOxujNgqsAW2BcO6cwLg9FuUjQ1XlaNmhCQCQb/N8VNemA5lIKCR?=
 =?us-ascii?Q?kZ43gc70ZAlNbgjpvm6gj6FjbkX0SG2F6QIztCBofSrS8s/zUgnd1shx3e56?=
 =?us-ascii?Q?BCavTYuY106ueDprAibCv8t9x8VHYIngb9XYpnH25lqgPCP7cq/Pd2p//rd2?=
 =?us-ascii?Q?EUcI909MkZtF20HyqntYk1cRL1AybBNvukY5Gx4cv/ykUdnRltqER671VB81?=
 =?us-ascii?Q?e0EqEEa2RphBHOdbMBsCTxuE/jHIJZdJxY2tM00+zwNw2RUIpOkTKIrcEJ+T?=
 =?us-ascii?Q?g8P7u9eJNY1l7XwszZN2t9Sa87D4AgIV548hNukqPN+fhHJQdiajRFrjkI2j?=
 =?us-ascii?Q?Cy98NIni+ulBS4wq/av10qkqOnSV06x5l/+trKrQ3v3+Tn79v+skkeDLOB5D?=
 =?us-ascii?Q?LnCy+CqtFk6wIxkLF73NxkHXWeexkBfsITBUqZTfE1Ao0IHHcvhwiTs03dyh?=
 =?us-ascii?Q?hvFv8YWnAEzVf4R+1lKBCBjAU9Z1FeBmBJeco9WFsUS2NaXIpXTw+RFRytO0?=
 =?us-ascii?Q?dE9Lel4WrI2bRqs+95hMNT0N4dx++Sdvc7zHEEYt+WNS07KyWgwVQjwyhABD?=
 =?us-ascii?Q?DkZF9tkWPbjwFnMZGeYQtRD6gdp7vJjWpUjRlbmTz7z3HUb97rDQpPUs8HcW?=
 =?us-ascii?Q?jk+XDhz16KBrmNF6QTUD0kGBin2wPlfzqm7ae0gLQqu4XFJPR2E+1aCqH6Y2?=
 =?us-ascii?Q?o96DaAA4fppm1PleAuVqpBX1ve7gsZRh3mspLSjT8O2UKFUgNOb7x9ogIjpK?=
 =?us-ascii?Q?wV1ogoVkPw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa27fe7-4825-466e-5ead-08deddc253d7
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 13:59:43.4731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A3In19SjHPt7KINPtEDKmZvsnWQ9aj59GUKw45TVgjtyxwCX56FHorn5lcOkHGV7a4HznWeJhZFhzoaD6j/Atw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPF271E4F3E3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[vivo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[vivo.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[foss.st.com,kernel.org,gmail.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[panchuang@vivo.com,dmaengine@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-12198-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:amelie.delaunay@foss.st.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:dmaengine@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:panchuang@vivo.com,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[panchuang@vivo.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[vivo.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vivo.com:from_mime,vivo.com:email,vivo.com:mid,vivo.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 68BB873223B

The devm_request_irq() now automatically logs detailed error messages on
failure. This eliminates the need for driver-specific dev_err() and
dev_err_probe() calls that previously printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/dma/stm32/stm32-mdma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/stm32/stm32-mdma.c b/drivers/dma/stm32/stm32-mdma.c
index e3bbdc9ee36e..26e6c117f89d 100644
--- a/drivers/dma/stm32/stm32-mdma.c
+++ b/drivers/dma/stm32/stm32-mdma.c
@@ -1713,10 +1713,8 @@ static int stm32_mdma_probe(struct platform_device *pdev)
 
 	ret = devm_request_irq(&pdev->dev, dmadev->irq, stm32_mdma_irq_handler,
 			       0, dev_name(&pdev->dev), dmadev);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to request IRQ\n");
+	if (ret)
 		goto err_clk;
-	}
 
 	ret = dmaenginem_async_device_register(dd);
 	if (ret)
-- 
2.34.1


