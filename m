Return-Path: <dmaengine+bounces-8787-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCYmMnMkhmlSKAQAu9opvQ
	(envelope-from <dmaengine+bounces-8787-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 18:27:15 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EE8100EE7
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 18:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF6B1301AD34
	for <lists+dmaengine@lfdr.de>; Fri,  6 Feb 2026 17:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A6F3DA7CE;
	Fri,  6 Feb 2026 17:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="gRo0vvfW"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021088.outbound.protection.outlook.com [40.107.74.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5813D6693;
	Fri,  6 Feb 2026 17:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770398819; cv=fail; b=OBoaiFHVkeoGAssCuBgLqvG71mgxAPXQzgXJAFo79QVdojycfPYTJPNz2Ie7euRMvEiJ1gSzMcB+OMR9Rj6CAVjyX/zc+jwToHKVb21UxIgi7ibNHORaz1h1J3HTTZKZXCfUS2TbzAAfrlwucPn9/Vc2EjS5cI65/2mDl7bg4UU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770398819; c=relaxed/simple;
	bh=iS/pN7ZRy8+Y3qJk2Esl4EBbJtnuyPQgCs2K18eI7Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SgQ0cSh/oh7Op+i/5gO2/eOr6I/unTPaCyYQdAPD8Pmi7vDJ4izr86UoPAoKietaIPR3qf8QOUq6HVe3yibC3GTthH8Rv6dsaFEiZ9LcNKahbjcvKI8p+eHpjvqa/qSpT47b6EqknK7s6yxquYI2zhckS7P0Y1z5Anwy2GtuMlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=gRo0vvfW; arc=fail smtp.client-ip=40.107.74.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P/rVkD4SSEIrwwnsDbmeWsR5PrWrLbB52eOw0NhNxBkitryCGL3WwH9dnDHcVvirQ2SbStxRGfs1kiTH4SPeV0GiG+QrI+PAcOpOIDWN29jYBEduKr4T/An53OLBqSK3ixSPRgVrfJZU82SW0XyS0PLwgFasvbhmmub/UTkYkMunfuZg6hQlwtKEXCDdFrRgEYO6YK6zj1SEZwu7aur1mqo3HeBSZEErsygDk1HebdWlc7t/Mhs9WUjAc8jOjaLIVTSRSDndc2n55rxpm3rRj+bDdtKYP2vg+EIgkqLecgEBjBci2nHHmrrcw3DmF9brAtZATra5iC3Yf6Ah6IPKLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SnPRhJhOq0+bGdxyR6/yImP1ue7aRrNL+RLbyUJSBHc=;
 b=N6K7ZsKKs91QnYiSTad11xr44NoLI+ozcd1ThUprMEcCj679WYVummvavYWiPX/8gKmbkrM1RwhH9AqyOUBQBbuHQTPFhbbAybo2o50A+5lawhBRwhNV1CX5HcxMq75T3j7VI3cO2FgCMwTg+8Ob32oCUBqutPWOE9Qw4pb+zEjkMHep3vpzkMqEVFL2rX/QqirniNtE0MJ4a+UAf0SgV1ZyV9P1IhfT9xRlCh1gxivFtLkvaLD7J47txCl3zxcVVadAUT/+BcxAFo8XPKbXK0LNelu2xusG7ybOZ4phkh2rw2nc9hJVxQlkUtmUkbDjGLV8ean4Nm5SASVL6vpNjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnPRhJhOq0+bGdxyR6/yImP1ue7aRrNL+RLbyUJSBHc=;
 b=gRo0vvfWEyTalm6+nMY4bO8mgIMD+a0Fyum4NuI7UaWGlvpMTEfo6OZrXnaBjHCAmNjEUG7twASgH9/cgahZXKsMFG6ROsQ9KTkJMOHa9vbc84w8rHVro4cO/7U6GbwiyymFqItmZnzPGxpJ4sGYKD/peFsPJdgv2PbqdCwrOQI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB5571.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1f1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 17:26:54 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.010; Fri, 6 Feb 2026
 17:26:54 +0000
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
Subject: [PATCH v4 1/9] dmaengine: dw-edma: Add per-channel interrupt routing control
Date: Sat,  7 Feb 2026 02:26:38 +0900
Message-ID: <20260206172646.1556847-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260206172646.1556847-1-den@valinux.co.jp>
References: <20260206172646.1556847-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0053.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB5571:EE_
X-MS-Office365-Filtering-Correlation-Id: c4f0338a-c054-4e4e-87d1-08de65a4ec3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NIGw651rsxeO6GCaf92xsCykSxLMZbM/T2gd7q8CEJYC8tayApz/RFQ21vPe?=
 =?us-ascii?Q?f1rpw+obMTvURTa0w7NmdT0yGPqFamJbS+aED1Y0K4Txbh2kp8Jpw3d+1OIP?=
 =?us-ascii?Q?cuj0pSLbKQBPaazOtwYBuLifI4z3lbLYMvugNNWWH+C+1DSu36jY+2jIzaLf?=
 =?us-ascii?Q?/zAfgYZCIOo7MAk1iY5pivcUIB1MG7HAWX1r0Pnpbkrdw4VfSnMusOU9D+Uq?=
 =?us-ascii?Q?w0wvNzvseZ4As9dyLXqOtTEf27EHLEF+341K+LfmNQE/0aDoJgtLf1gLKpdM?=
 =?us-ascii?Q?Nn6DmFQ/oYCEU4+Pa8XSedzP7IjyDZBbtKG35ItOrxXN/N/X8vpHioqXFz3j?=
 =?us-ascii?Q?KavIVa7ZpJ3bi2Ofz3X10wNVLu3cevfHlcXB1TYdrbWisNZp0SNa2hTeEvcy?=
 =?us-ascii?Q?SdRV1g4ebOFqneWurAf68Nr70y7MHwCDWUtfE6ZAnhl9RjC618w1tKDPpYPd?=
 =?us-ascii?Q?I/DTQJs1aAVEjv1c8unh4SRh0dJQSEp/RVhk/al1e2y3BuHtr8hackQjrxg9?=
 =?us-ascii?Q?RzlKWWQd+Xx0b4uNCRxFcYXFKkCtsfObau0j+0Bmcs/HtyzfNL2shqDqAMce?=
 =?us-ascii?Q?5TO5rRkk2EA3EfS+0P7G0+DYHOQP9lgK4LbV/ewxZtTqTRBmjrft4fq/AgLY?=
 =?us-ascii?Q?wPRQ+Jd2Dxyb2e6G2J4yTDoCOrAOYbluuoQ8OIg3aShVNleuYqnB56KzQKRP?=
 =?us-ascii?Q?pT/JUtozGt5v8bOXf6ZQwnk81hXiOC5uXhBjw60U3eK3On1UuUbabtVuQIPE?=
 =?us-ascii?Q?MqLS8pS0yOdwmLOTrV8e14ajk94NWW4WZHH/DUbPTcQuJNrnCq06aWeeUyf0?=
 =?us-ascii?Q?LopU2rKB/8QUed9SEdX0tyLRq79R2TTVab8pFUs/BR0CVl8r7xveWgIKmCOT?=
 =?us-ascii?Q?T3DftO5d3PgGg1DAZY3DO9U3icNcIukb8zAULXvEUKmJoZcDRGcRQ9jIIvuK?=
 =?us-ascii?Q?ITIyEi+coVIj0obXN8iJCGO4GwQMtcbXuWZWQ4Pn626dAlU2ZVne0FGfaBHh?=
 =?us-ascii?Q?HIybCr/O9hOJFLsKqn5UETXhsV5YVFHdih/kdbqVequ26+Qof2iS+8KglKEE?=
 =?us-ascii?Q?BkL6JVmppXPQ1NZ5S4nFbANuxy6rqvO7QKuQMleSkXqRxCSAtWZrjj7HOGXz?=
 =?us-ascii?Q?NUAvFbPCfE2ZE9RvmC1b6m91QZW7mfsrxobtxvc8dnIXMP6lcbPZRlemu+ZP?=
 =?us-ascii?Q?v8gGLHIp83NLBsmQnI+5ascp4m1SppxaCBI56tF7dLWv9A2u0KUmB1D6u7ob?=
 =?us-ascii?Q?c8pxfab0deCiYVE8Fze6Z61gjsJgJ1USQOOonOmF2VnQp1dZnX5/5OmDGPQf?=
 =?us-ascii?Q?Pe6wlw/r2k0X/I+IPi6HpnU61YDybGUG6o2snVAdoXA0AnNSnx064EyiHDNF?=
 =?us-ascii?Q?jKHDwB+YG3jPJQcSwQk5k/C+/DwwcFMflA5fHiwMdExZLkTvhGA4pK3mCUrr?=
 =?us-ascii?Q?BUiwh8+qPCAHqS+JSY9QwY141uqDtUtkN8H2uzNlkjT58ivHGBHbQP5WdVrD?=
 =?us-ascii?Q?5CQIbNbxk7IRhQtj7MtMi/WtvttW7hj3p2XXp6Z+b2uqzP/R6nNP53HFGkDa?=
 =?us-ascii?Q?IiuvrduaCZEJLnSaJhI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9JC+LCl8LcqYN9ddw28E++59+JFFPq3IC61tfFfzRdq2x1dc3ulKMXcm7RJU?=
 =?us-ascii?Q?zHt/NoWG5tCaYZfXeGJ/5yHlakmt+14L19iVvrU/Klo7hZD10KEXMmTl6Lhu?=
 =?us-ascii?Q?ip5+tfOOdDesiFz7deubkUTjHSu+/pZpSZelxPtW17j9xkyfBOo4RoqDgJrW?=
 =?us-ascii?Q?fVg2J/nCYTYt8lQh7ujKPhQ65JDUJB0QsxSi5U+QzQ2IRBtvkw/of+bVsLbD?=
 =?us-ascii?Q?cfrW7fdY+yQ45IsqpiKt8tBSPEqBnQq+sGCtvla+3j+OeesLiDdU4hLgRc5h?=
 =?us-ascii?Q?TGyA7QDvx+P2CqMxY+lQefdBjOyExV83JMzpZ18xDHA8v1/tQGEeGSa2JWrN?=
 =?us-ascii?Q?1cBfSL8ie0luczMcSUWrZyJgKXVIsbUxaimHWkBTF5wF+aogIoLsaT7TujpB?=
 =?us-ascii?Q?HSorGGZPhoIOfiz9EHpqwgetqOEke973PFRerEVV9j4hzq8COZ3nTzG7gGKz?=
 =?us-ascii?Q?kt7kQZFueeuFp06GL9xyPKq/W6wyWiJNluUNcNTz45NCc9IDhAZzKb6rXT0f?=
 =?us-ascii?Q?smQe6pidpkJDuw4hU+nrJ+m+SxpRAqAeBlwEGuS/Dn62Dmdt0wIETxJ2JnDL?=
 =?us-ascii?Q?976W40Bt92XxmZQo/gONBA/ZJPCn0AiuYPYU1z8ilkrVFfrFeQZSXsZuTn9v?=
 =?us-ascii?Q?Vxv9DHNjBCRxOGsayGwNoGNscsQ+TXUbHmPk5D1M8fvB4zyojTDwVxi+rWWV?=
 =?us-ascii?Q?olNyHlBppahP4PoyN9x2Dhz0LOFlMo/385EqiKO8djRm2nAqtehE/u4rBYCZ?=
 =?us-ascii?Q?nVjL9MzNzGcVL1MlruXDA9FjzwO3Fb8DYW1KAoEKV7UsqNtQ97I+hc/rMi14?=
 =?us-ascii?Q?1rJpR/rQhz1KnmLSZ64HMdfv/4tJksKPgq271JRr7u3Am1EUfIZAgjj/PEfi?=
 =?us-ascii?Q?qm8F0HhIJnSw6bxCc+JV+bzREQmrIZHRfNT9NPBF0wF9uvK55T4tNOiYmw2u?=
 =?us-ascii?Q?8s2Ob+MvQ3ErG++skjl7jVWE5V7vzUlt3czbVW+8mq2AyVWW3mw03h9re2cI?=
 =?us-ascii?Q?uP+DerL9FfLnphf65wNkL3teRYoYYo/jXYMobJcIKhAG6Mh2JheNo8QkQomm?=
 =?us-ascii?Q?D93xPa88FYKmnVqIU86poLF35CZleiFdUTqc/Rh1rLSKiJaZLRkRaDGstpXU?=
 =?us-ascii?Q?eQ+bLYQJv52yohhoQ8hwTYpNgjBUUJiLrsB8iGuaZG7pRIzEZnW+MB1tChb3?=
 =?us-ascii?Q?lRpYFXxOAAd6GqoYpS/Sx8Gt9z/5M6ZB16NMritHhTwimnE7gd0GXE22EJjH?=
 =?us-ascii?Q?Xy0+hnPt0qiirnO8vP9Ih/prRwhu85vT8y4vJIGE8BQTRQvOrvWxlaggFK9p?=
 =?us-ascii?Q?XKEmHWu4EMqexzDfUOy1lANq2H93F3ZFcPEyKAp70zIp/ib15iRLa3Vw+hm+?=
 =?us-ascii?Q?yGGKlIzReDoVamFQEC9+cFJ/fkyh1DiayMJS9UWqaXWQHqnRcx2RTxRgE5hF?=
 =?us-ascii?Q?aFfhHV5NCD2sYACID0z72ux7DsUtAwReLNHMwC7caMNMc06PILTY1OaFFLVZ?=
 =?us-ascii?Q?+wjMlxIkT8r4ebqTx7sYO2djh+kvHdzaHqT71pz5G74X/r281wS3YVLGtooe?=
 =?us-ascii?Q?8fnLL+xLYsfwCY8F/8fsZpBjH5vgdHRlFA3mnaYdquYjlXzkjPtVMxSdzkep?=
 =?us-ascii?Q?fUb9wJ3K0hdU/83Ev8uGUeF0P5vPnGJDx+w38wElDg5NOYlNWeQeWr8FLoox?=
 =?us-ascii?Q?ECeV/QY6ec/kUMf6CagMKRPS/fyzK7cPFgeh5UP3txU3R6ozXnGRxyieu6d5?=
 =?us-ascii?Q?H6J12K20Q4CO2zWnOlhngV4+ddgOYiyS4pe6FGtxm8++P5wdiNGQ?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f0338a-c054-4e4e-87d1-08de65a4ec3d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 17:26:54.6109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NtclWT4u8GBSFEOzZIr+sfhdiSxrkiqPkEUTigJGU+Vp+pGf1VjQuMruxvWlIs8JW9tlRmmkWN99fDvnJxGpLA==
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
	TAGGED_FROM(0.00)[bounces-8787-lists,dmaengine=lfdr.de];
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
X-Rspamd-Queue-Id: 27EE8100EE7
X-Rspamd-Action: no action

DesignWare EP eDMA can generate interrupts both locally and remotely
(LIE/RIE). Remote eDMA users need to decide, per channel, whether
completions should be handled locally, remotely, or both. Unless
carefully configured, the endpoint and host would race to ack the
interrupt.

Introduce a dw_edma_peripheral_config that holds per-channel interrupt
routing mode. Update v0 programming so that RIE and local done/abort
interrupt masking follow the selected mode. The default mode keeps the
original behavior, so unless the new peripheral_config is explicitly
used and set, no functional changes.

For now, HDMA is not supported for the peripheral_config. Until the
support is implemented and validated, explicitly reject it for HDMA to
avoid silently misconfiguring interrupt routing.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-core.c    | 37 +++++++++++++++++++++++++++
 drivers/dma/dw-edma/dw-edma-core.h    | 13 ++++++++++
 drivers/dma/dw-edma/dw-edma-v0-core.c | 26 +++++++++++++------
 include/linux/dma/edma.h              | 28 ++++++++++++++++++++
 4 files changed, 96 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 8e5f7defa6b6..0c3461f9174a 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -219,11 +219,47 @@ static void dw_edma_device_caps(struct dma_chan *dchan,
 	}
 }
 
+static int dw_edma_parse_irq_mode(struct dw_edma_chan *chan,
+				  const struct dma_slave_config *config,
+				  enum dw_edma_ch_irq_mode *mode)
+{
+	const struct dw_edma_peripheral_config *pcfg;
+
+	/* peripheral_config is optional, default keeps legacy behaviour. */
+	*mode = DW_EDMA_CH_IRQ_DEFAULT;
+	if (!config || !config->peripheral_config)
+		return 0;
+
+	if (chan->dw->chip->mf == EDMA_MF_HDMA_NATIVE)
+		return -EOPNOTSUPP;
+
+	if (config->peripheral_size < sizeof(*pcfg))
+		return -EINVAL;
+
+	pcfg = config->peripheral_config;
+	switch (pcfg->irq_mode) {
+	case DW_EDMA_CH_IRQ_DEFAULT:
+	case DW_EDMA_CH_IRQ_LOCAL:
+	case DW_EDMA_CH_IRQ_REMOTE:
+		*mode = pcfg->irq_mode;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int dw_edma_device_config(struct dma_chan *dchan,
 				 struct dma_slave_config *config)
 {
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+	enum dw_edma_ch_irq_mode mode;
+	int ret;
+
+	ret = dw_edma_parse_irq_mode(chan, config, &mode);
+	if (ret)
+		return ret;
 
+	chan->irq_mode = mode;
 	memcpy(&chan->config, config, sizeof(*config));
 	chan->configured = true;
 
@@ -749,6 +785,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 		chan->configured = false;
 		chan->request = EDMA_REQ_NONE;
 		chan->status = EDMA_ST_IDLE;
+		chan->irq_mode = DW_EDMA_CH_IRQ_DEFAULT;
 
 		if (chan->dir == EDMA_DIR_WRITE)
 			chan->ll_max = (chip->ll_region_wr[chan->id].sz / EDMA_LL_SZ);
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 71894b9e0b15..0608b9044a08 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -81,6 +81,8 @@ struct dw_edma_chan {
 
 	struct msi_msg			msi;
 
+	enum dw_edma_ch_irq_mode	irq_mode;
+
 	enum dw_edma_request		request;
 	enum dw_edma_status		status;
 	u8				configured;
@@ -206,4 +208,15 @@ void dw_edma_core_debugfs_on(struct dw_edma *dw)
 	dw->core->debugfs_on(dw);
 }
 
+static inline
+bool dw_edma_core_ch_ignore_irq(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->dw;
+
+	if (dw->chip->flags & DW_EDMA_CHIP_LOCAL)
+		return chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE;
+	else
+		return chan->irq_mode == DW_EDMA_CH_IRQ_LOCAL;
+}
+
 #endif /* _DW_EDMA_CORE_H */
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index b75fdaffad9a..a0441e8aa3b3 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -256,8 +256,10 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 	for_each_set_bit(pos, &val, total) {
 		chan = &dw->chan[pos + off];
 
-		dw_edma_v0_core_clear_done_int(chan);
-		done(chan);
+		if (!dw_edma_core_ch_ignore_irq(chan)) {
+			dw_edma_v0_core_clear_done_int(chan);
+			done(chan);
+		}
 
 		ret = IRQ_HANDLED;
 	}
@@ -267,8 +269,10 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 	for_each_set_bit(pos, &val, total) {
 		chan = &dw->chan[pos + off];
 
-		dw_edma_v0_core_clear_abort_int(chan);
-		abort(chan);
+		if (!dw_edma_core_ch_ignore_irq(chan)) {
+			dw_edma_v0_core_clear_abort_int(chan);
+			abort(chan);
+		}
 
 		ret = IRQ_HANDLED;
 	}
@@ -331,7 +335,8 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 		j--;
 		if (!j) {
 			control |= DW_EDMA_V0_LIE;
-			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) &&
+			    chan->irq_mode != DW_EDMA_CH_IRQ_LOCAL)
 				control |= DW_EDMA_V0_RIE;
 		}
 
@@ -407,10 +412,15 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 				break;
 			}
 		}
-		/* Interrupt unmask - done, abort */
+		/* Interrupt mask/unmask - done, abort */
 		tmp = GET_RW_32(dw, chan->dir, int_mask);
-		tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
-		tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
+		if (chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE) {
+			tmp |= FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
+			tmp |= FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
+		} else {
+			tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
+			tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
+		}
 		SET_RW_32(dw, chan->dir, int_mask, tmp);
 		/* Linked list error */
 		tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 3080747689f6..53b31a974331 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -60,6 +60,34 @@ enum dw_edma_chip_flags {
 	DW_EDMA_CHIP_LOCAL	= BIT(0),
 };
 
+/*
+ * enum dw_edma_ch_irq_mode - per-channel interrupt routing control
+ * @DW_EDMA_CH_IRQ_DEFAULT:   LIE=1/RIE=1, local interrupt unmasked
+ * @DW_EDMA_CH_IRQ_LOCAL:     LIE=1/RIE=0, local interrupt unmasked
+ * @DW_EDMA_CH_IRQ_REMOTE:    LIE=1/RIE=1, local interrupt masked
+ *
+ * Some implementations require using LIE=1/RIE=1 with the local interrupt
+ * masked to generate a remote-only interrupt (rather than LIE=0/RIE=1).
+ * See the DesignWare endpoint databook 5.40, "Hint" below "Figure 8-22
+ * Write Interrupt Generation".
+ */
+enum dw_edma_ch_irq_mode {
+	DW_EDMA_CH_IRQ_DEFAULT	= 0,
+	DW_EDMA_CH_IRQ_LOCAL,
+	DW_EDMA_CH_IRQ_REMOTE,
+};
+
+/**
+ * struct dw_edma_peripheral_config - dw-edma specific slave configuration
+ * @irq_mode: per-channel interrupt routing control.
+ *
+ * Pass this structure via dma_slave_config.peripheral_config and
+ * dma_slave_config.peripheral_size.
+ */
+struct dw_edma_peripheral_config {
+	enum dw_edma_ch_irq_mode irq_mode;
+};
+
 /**
  * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
  * @dev:		 struct device of the eDMA controller
-- 
2.51.0


