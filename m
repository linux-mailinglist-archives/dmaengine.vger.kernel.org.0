Return-Path: <dmaengine+bounces-8797-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHISOFAphmmuKAQAu9opvQ
	(envelope-from <dmaengine+bounces-8797-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 18:48:00 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B23101618
	for <lists+dmaengine@lfdr.de>; Fri, 06 Feb 2026 18:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D033301ABBA
	for <lists+dmaengine@lfdr.de>; Fri,  6 Feb 2026 17:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504EF361670;
	Fri,  6 Feb 2026 17:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="A5rkqz/e"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011015.outbound.protection.outlook.com [52.101.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA16030FC3C;
	Fri,  6 Feb 2026 17:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770399845; cv=fail; b=gQlsbISwpeM4EOC6b8VIiYAkHqTT4+PL8342TsrINjVp72gVHsxNLWo7VLWUO3qWOMslXE25K1OUxdNWjsrmOi7u7XnEETpbn69fhHdW5K30Vh/oIj5N1oER+mxt9qDyowSxvsIOgOrREmsO9XCWDMYJhCcDwA2x2xS4l3lzI4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770399845; c=relaxed/simple;
	bh=uNWfLP7WvPXL8WtG/YY8ThucTSaxHDyDz6ZvoWBleGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NVZHJT3zztBRPGUFDJWJQ5mWFpKuHKQzppFpWPh01gqmkSxoIYMdKO6TNvB7RS/KZnXjvbZYUk7RCx+am+5HO8ki+ka75qRq1fjZn1v5Z1qJ+tcjGnchUkqy+2SvR8vOD2LcHSXGqZHI5bHwey0kkgmaFrpvpXAuu6L1DrLVbtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=A5rkqz/e; arc=fail smtp.client-ip=52.101.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uatIqcMDntXZ2KusgMTGEvKES5LyRkZAPpzGETZIn/bd2IPbhbx16clGSROo9HniOrvwSHDjyD9O6jdZ8Pt+oBmVwM4jB0l8r+wt5e9tPxwCru9B+ylmQ1znkGsXmm7Nl0IVyyCvgWXMA4W+EroFgB/VoNd+Dahl7sjVI70oLJp4RN6zwbF4PeTkg8PC2Qv/Vd0jnNhgig0QmMYjx8LxsTN21D2YT8IH32rtfERQGA78kdagUIERWGjL+sFhs2GtatFJ4JUw/kJC7ujVS776z0h5quFlMs162HmWSQPs75QiDPYCn+DjtUKUovCd0zlPw4VzaLUOGcsELnL6fA0ftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KE9NCAAor3QekaykZ8JRcK460UNg/rWPn/0lllytWzQ=;
 b=jUukF2NWiTezH5gBmEwwqrnR6XiS9WDYP4nXtnURLXfLJlTEH//LLWKIzcm3ji6/gB2zNmMr6Ezn7emQU0ARbrDwLimVMP0llbDdmJ9avl64PpJP13z+JvSSslcHfNqP8snxVjjavyhBacVmsWQVMoqp0X/GsV+9Q5LU0Rdn+DIbXLl93++5FF25EnOyxvkI0r2m2EnEblrXkW8TiWIb8al+QhraMSDCsDq9629V+AjktDY6a3rlbqEVUxDtIKLTLzEwJYkKsA8bPqcbmLwHkqoW7yLUCBZXONHZHKgrFyq5cwqrDICm7EccSvOAWvY+MkNLCCBAuG4bWvDFy9Ke9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KE9NCAAor3QekaykZ8JRcK460UNg/rWPn/0lllytWzQ=;
 b=A5rkqz/eG2sC6G1+q1/dXSUMUES9CJ7J45gmvH7LEnYF089FPv/GRSnkfpVxY6QTmTnpJ8KeSKQxuEkMlelL7szLufDUY6AewMbIl+u5jzH4LdOBbe6DBWbwGbxEZ2TFefBXZKYIg2havhpHdXxn6jjufb3vJe/6RP8aDYdI3XkigQ5WM4wNdUueAS0IPij1e66tjQhG90V/6YAHXIs4w8ApMqQN4O+dgL7FrCQYNY3mDA4GVBfoz2Ow4+J2eAt46QK45NLwY6MLSuExemB0/nCm195I2fg2JyG7m4xdtfizLCHge3wlPzdDg67liMcTDE+nAOznalUVlso2H2SDSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AS8PR04MB8738.eurprd04.prod.outlook.com (2603:10a6:20b:42b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 17:44:02 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Fri, 6 Feb 2026
 17:44:02 +0000
Date: Fri, 6 Feb 2026 12:43:54 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: vkoul@kernel.org, mani@kernel.org, jingoohan1@gmail.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/9] dmaengine: dw-edma: Add per-channel interrupt
 routing control
Message-ID: <aYYoWtkM0EhP1Od9@lizhi-Precision-Tower-5810>
References: <20260206172646.1556847-1-den@valinux.co.jp>
 <20260206172646.1556847-2-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206172646.1556847-2-den@valinux.co.jp>
X-ClientProxiedBy: PH8P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:345::9) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AS8PR04MB8738:EE_
X-MS-Office365-Filtering-Correlation-Id: b60f8ecd-f2b8-44ac-d9e6-08de65a7508e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|19092799006|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jknkFaG1GUaDlqWrOVzknyBAqoZMOlKYH9ZNrEP+VKbCC+H/4DMmLDUfOTAv?=
 =?us-ascii?Q?DoBC5wbDcPp6uGxmj7/464IOWXykT5kIU4SQXznURIsrBewJEDLqrBUg6aEn?=
 =?us-ascii?Q?vF3flKT3dBpFVVxfGy430ZOyqxQX3onoXnsz2IBHap3xX8xPdo+1TXK8Ug5X?=
 =?us-ascii?Q?p2VZ0Z2xT8QTRjJAz+sb+A9Oi7EQlGgc+c5Z1LAMz4M9jO4DbvVciVotXFOE?=
 =?us-ascii?Q?wj+KIPZPcGq+1UF3t5PFVKk5DaqzQpnQRwtEJ6Dqu67WHAHHKv4IH2j4Mp2L?=
 =?us-ascii?Q?POpiRgIiY9tQW9OuCnhvJv4B6lpoiCn18n3Nu8r4CRl/Wu0u2bSCVhnPNkoK?=
 =?us-ascii?Q?KrkfK3aRjNGgzobCCJdADharUSLNHgNlP9O9zfzY+SaP3WvxQsqUVkzSO9SM?=
 =?us-ascii?Q?GFFayyTNNKP5zvm4IjwsoSzzwF7jZZWAgP5o/Eg2VRWWKj7pCi9Dz3kooAKQ?=
 =?us-ascii?Q?9BqKQo9mZ9ADWpkCHhXsoQD2CoDpod/8CpCN8coNS7FW30NRX5bCXCdmiRvn?=
 =?us-ascii?Q?HVePoKdNF/DkTPY61CAQD7yak0c1JGc8prDQGi4tyF1h5v60GnJTfw0DyHoY?=
 =?us-ascii?Q?fYFNOg8y7cdby1KZS4Pb/VpgdT+Lx7B6ZFcWkEjQNGLM7kXJSiiexE8C7NMj?=
 =?us-ascii?Q?1sxDQvQNOc5nvbemj/umAinKf+1v1sWBE1OiztBgsFJZNNzEGcKr7C+6mUgE?=
 =?us-ascii?Q?35NY5o6BaAwacERYT+Iq9YU3ZhlrbK+pLo1ah+LaTnFsJIfP70RXVPpWQ/RV?=
 =?us-ascii?Q?Z8OPXFCrwSMzz7azi11AX5pkaG2lueJjy24jID379A/9EQQeM7kTchKvQvID?=
 =?us-ascii?Q?buNgRfYlWcHmOuvxROqLk2ar11jk7LC5F8CyeKHuRCuCPtnFF9rfukA7jKxR?=
 =?us-ascii?Q?n3b25xc4wRGL9CRQTYFARo+ANvfFoZE2EW9+Lv78YxRF36Qw5gaNOrFfZ5Z8?=
 =?us-ascii?Q?NDLjyHMBqbFLx6dVjD3rLZ5a2PoH42E1ZzXjoiPOqlT8roXCcg30uiLvbHK0?=
 =?us-ascii?Q?S1KYGJOT7My5kCcjX9+NM/JF3Or8ODdW7ZWxy68hzMPz2vQo3p6F/E38C23X?=
 =?us-ascii?Q?uFfEhKYTpMXCmckg871KELhbnN4bQTD+48FlYM1FL5ZNW029IttnKKrbeaGD?=
 =?us-ascii?Q?ZjMT6tmSL/Wp45ZI2K1px6B2hffqdNcKRFPCuRqb3gmV/8iDnaVFWnKY886k?=
 =?us-ascii?Q?yB5xlmLEROaY7VDCZ6OxJ5u6Wlw0fCQdJTgDJ0p3TrkcTKSKF2U/7nOu9hXj?=
 =?us-ascii?Q?K6MlQ+zsJLyjXvVtYklb6raYtLOxefggHzLu7R9Omqvnz0r7a5rWdxKRt5F6?=
 =?us-ascii?Q?rb5fDkNbOksewkuBW6gJqTeEgX+9eBLOAGYImGGVVM2F6FJXHT21KK4uSVEu?=
 =?us-ascii?Q?s31KNcwxfdIc9z1Jb96Zl16481v8dZ0nrjuncKQx3bHY4Cvb9e6YnKTGvlzi?=
 =?us-ascii?Q?ey86KtOrjOZNJHDS0NXpk5Fkbgv6ExxJOdQNiAJiAc9RYC1mUOLAVzKc4YEa?=
 =?us-ascii?Q?fvP742uYCWCGGI9jxYaCKFpq7N+AZrwiEoV1Y23OLmQfWzEnZ0rcamSoUkfN?=
 =?us-ascii?Q?0+tEPnF7olU3ygH0+1T5uHTMMs0DYcoaeDHG8qb/0FJdg07KDocv4sPP50y1?=
 =?us-ascii?Q?irqHOJvU/cD9Ciw8uaW1MwI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(19092799006)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AvdT9vo8gVquwZfE+tBqDSE07JAWlSLEKjXv7QV5F2Q6CJi35mP3irsPVv70?=
 =?us-ascii?Q?JovP1cdzkwBkstBHEzA5I3LRk6gvEmoyuhniuAqA1ZSivOW1M46sXG43tVIs?=
 =?us-ascii?Q?P2QCbfqeggxiteWRD+xIY+bqf20X+7L+XFUJAVGdMYuKfRv8hVAZYS6YW6IJ?=
 =?us-ascii?Q?7OXJm9KiHJD9g5Tlx7iOGa3Qq8A/aCituNWGDT2vM6Sjuj2VWcYAqJhsvfYu?=
 =?us-ascii?Q?SgVVePpo6BX5pyC6thymWM3QRyprrUIDoK02XPnIIHlN9IP9d3hpw/Gtrwnc?=
 =?us-ascii?Q?M4x2TtL5gEVcgwVB5w8CCVDVObi9DIuhvIVVR6x1K6U+OTFJAPhke93c/pzu?=
 =?us-ascii?Q?T6wrpBk2zSjMrjkOKUqgFmVEvnHel9d3+B7/mp1ohW4MZ7wWOCyW6deRcQU1?=
 =?us-ascii?Q?nQYY9aRryebwcBWiAZTTZ2UxBBD60uHlFyU+naS1tKt9RbfnjPEPkN8DNXmb?=
 =?us-ascii?Q?/e5geNhDhjT/FjkZENC5EAd2dvcwvZYlbU4g72Qmk85/bDMNK9KWb3ZwxL86?=
 =?us-ascii?Q?jvEvJbD0poDXWwZwM6hl4L+0steupkAa1Z57XWkXAqrvHg7c60ODQHJ7mpAO?=
 =?us-ascii?Q?vumGH/zdov8YEs3L8QyJ6Dg0/H9aapk4zQvQLyFpFp8KZFCIpnjG20cTm17I?=
 =?us-ascii?Q?yXWVXEKFvk8IiVuN08S5jF/sGTMpVN/CamyUGVD36I+TPIjkucQ3T1wJd+XY?=
 =?us-ascii?Q?K2eI+oDRiMpz+/AA66Nmsor/1/321lVoZ1SPDfIYHIbfyYmLV48FlQnj3Xa0?=
 =?us-ascii?Q?PfD4zdg9cwen5ObyB4YKmSoUNQ9acV4d0KBDKcxeyCFdlLxCUgfb+YXMNpkq?=
 =?us-ascii?Q?Pp5rUGDh4U1KdmRcBP8RHPVIbn5TGkoGuAeAgUFjgcYXEtpwCYhOEqrVHu7r?=
 =?us-ascii?Q?bOmhLCxDvdAWpC1eTj2Hs9FhaqLesMiX+Uuhm9SetfCVZdZOkXSPOxneZQS/?=
 =?us-ascii?Q?rPzvf3vmbnuJFfTpkQtpRTqspj0h+bA7yjfOJerVw2HwCCXelJ0eNB6IcCl/?=
 =?us-ascii?Q?iWMZdQIJEN75v7L3R09byPGKB1dfYxqcjtYWicD2HrptsCcyq+rLWxnx+3Nf?=
 =?us-ascii?Q?QP1XkqLKDNl6ZGO85KQlZejq5ub2aHVBGJTkDPvjLPwleHc/Sm3XBF/w44YA?=
 =?us-ascii?Q?eL9uxqdl7XDW40KcqRjp5Cd+QRoc/GK+ot3LX/4z1MUO9LOAIQKjh3XkPPfM?=
 =?us-ascii?Q?8JQ5OFaHSU5Eyt+3ADkd20G77cL++18+kHQe2ImHSqStJn+1diRqrZKK4+Z2?=
 =?us-ascii?Q?f6/JBZs2NHA6DnoJwX5I4bc8DjwaQPe+r3+bSn1GCW2ExtMIbN5t2v35GWKo?=
 =?us-ascii?Q?FMbp5abqiiW8cY+mNfXUWRF9AM6b8hNFoZgrVP0JFh6wR/Xb7GzUbLoQ4oT7?=
 =?us-ascii?Q?X0VkLthfM0D89OQABKl0dyi5s4JRR7p6NDZp2mCmf1rhlcJfLjSrhd2fZ6JQ?=
 =?us-ascii?Q?npk88+Ot64Fq0rCt6dncW4W5mNPGfbM4D3WDVNf9SSHZb2QKFLnkC3kK0eht?=
 =?us-ascii?Q?Z9YTtfibGTLlZZ7aXqKxrTkKfNi4BNzLhgbmHw5W0WZ04PxGmfs6NAncH3AP?=
 =?us-ascii?Q?/aNuy1zBqEyN7TXdZR/Zs0j2oyidY+/m87lrQAzlsTqSmS+SK2tqiXNjdNRc?=
 =?us-ascii?Q?rPWAtFfrUXgZqjASrC36kHuAbVPyVqkligqARkDfP44qwxwilk6JD2jXcl1A?=
 =?us-ascii?Q?HZr28LZgqI7YLh6GYaWuMzPMppnBQIzVq5bwD1sIOa0FqaYHJ9MmlcsF+OXE?=
 =?us-ascii?Q?WZ+tppwPow=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b60f8ecd-f2b8-44ac-d9e6-08de65a7508e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 17:44:02.0843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gLySC1gIehoZVogw9UARXkwAT6TGyoCOFG7fG/N+mZNDFpCVDrsu+UkdnUZWkkkZmuBr/JhZOrC1silloCdHgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8738
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8797-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 54B23101618
X-Rspamd-Action: no action

On Sat, Feb 07, 2026 at 02:26:38AM +0900, Koichiro Den wrote:
> DesignWare EP eDMA can generate interrupts both locally and remotely
> (LIE/RIE). Remote eDMA users need to decide, per channel, whether
> completions should be handled locally, remotely, or both. Unless
> carefully configured, the endpoint and host would race to ack the
> interrupt.
>
> Introduce a dw_edma_peripheral_config that holds per-channel interrupt
> routing mode. Update v0 programming so that RIE and local done/abort
> interrupt masking follow the selected mode. The default mode keeps the
> original behavior, so unless the new peripheral_config is explicitly
> used and set, no functional changes.
>
> For now, HDMA is not supported for the peripheral_config. Until the
> support is implemented and validated, explicitly reject it for HDMA to
> avoid silently misconfiguring interrupt routing.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/dma/dw-edma/dw-edma-core.c    | 37 +++++++++++++++++++++++++++
>  drivers/dma/dw-edma/dw-edma-core.h    | 13 ++++++++++
>  drivers/dma/dw-edma/dw-edma-v0-core.c | 26 +++++++++++++------
>  include/linux/dma/edma.h              | 28 ++++++++++++++++++++
>  4 files changed, 96 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 8e5f7defa6b6..0c3461f9174a 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -219,11 +219,47 @@ static void dw_edma_device_caps(struct dma_chan *dchan,
>  	}
>  }
>
> +static int dw_edma_parse_irq_mode(struct dw_edma_chan *chan,
> +				  const struct dma_slave_config *config,
> +				  enum dw_edma_ch_irq_mode *mode)
> +{
> +	const struct dw_edma_peripheral_config *pcfg;
> +
> +	/* peripheral_config is optional, default keeps legacy behaviour. */
> +	*mode = DW_EDMA_CH_IRQ_DEFAULT;
> +	if (!config || !config->peripheral_config)
> +		return 0;
> +
> +	if (chan->dw->chip->mf == EDMA_MF_HDMA_NATIVE)
> +		return -EOPNOTSUPP;
> +
> +	if (config->peripheral_size < sizeof(*pcfg))
> +		return -EINVAL;
> +
> +	pcfg = config->peripheral_config;
> +	switch (pcfg->irq_mode) {
> +	case DW_EDMA_CH_IRQ_DEFAULT:
> +	case DW_EDMA_CH_IRQ_LOCAL:
> +	case DW_EDMA_CH_IRQ_REMOTE:
> +		*mode = pcfg->irq_mode;
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static int dw_edma_device_config(struct dma_chan *dchan,
>  				 struct dma_slave_config *config)
>  {
>  	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> +	enum dw_edma_ch_irq_mode mode;
> +	int ret;
> +
> +	ret = dw_edma_parse_irq_mode(chan, config, &mode);
> +	if (ret)
> +		return ret;
>
> +	chan->irq_mode = mode;
>  	memcpy(&chan->config, config, sizeof(*config));
>  	chan->configured = true;
>
> @@ -749,6 +785,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
>  		chan->configured = false;
>  		chan->request = EDMA_REQ_NONE;
>  		chan->status = EDMA_ST_IDLE;
> +		chan->irq_mode = DW_EDMA_CH_IRQ_DEFAULT;
>
>  		if (chan->dir == EDMA_DIR_WRITE)
>  			chan->ll_max = (chip->ll_region_wr[chan->id].sz / EDMA_LL_SZ);
> diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
> index 71894b9e0b15..0608b9044a08 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.h
> +++ b/drivers/dma/dw-edma/dw-edma-core.h
> @@ -81,6 +81,8 @@ struct dw_edma_chan {
>
>  	struct msi_msg			msi;
>
> +	enum dw_edma_ch_irq_mode	irq_mode;
> +
>  	enum dw_edma_request		request;
>  	enum dw_edma_status		status;
>  	u8				configured;
> @@ -206,4 +208,15 @@ void dw_edma_core_debugfs_on(struct dw_edma *dw)
>  	dw->core->debugfs_on(dw);
>  }
>
> +static inline
> +bool dw_edma_core_ch_ignore_irq(struct dw_edma_chan *chan)

nit:

static inline bool
dw_edma_core_ch_ignore_irq()

> +{
> +	struct dw_edma *dw = chan->dw;
> +
> +	if (dw->chip->flags & DW_EDMA_CHIP_LOCAL)
> +		return chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE;
> +	else
> +		return chan->irq_mode == DW_EDMA_CH_IRQ_LOCAL;
> +}
> +
>  #endif /* _DW_EDMA_CORE_H */
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> index b75fdaffad9a..a0441e8aa3b3 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> @@ -256,8 +256,10 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
>  	for_each_set_bit(pos, &val, total) {
>  		chan = &dw->chan[pos + off];
>
> -		dw_edma_v0_core_clear_done_int(chan);
> -		done(chan);
> +		if (!dw_edma_core_ch_ignore_irq(chan)) {
> +			dw_edma_v0_core_clear_done_int(chan);
> +			done(chan);
> +		}
>
>  		ret = IRQ_HANDLED;
>  	}
> @@ -267,8 +269,10 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
>  	for_each_set_bit(pos, &val, total) {
>  		chan = &dw->chan[pos + off];
>
> -		dw_edma_v0_core_clear_abort_int(chan);
> -		abort(chan);
> +		if (!dw_edma_core_ch_ignore_irq(chan)) {
> +			dw_edma_v0_core_clear_abort_int(chan);
> +			abort(chan);
> +		}
>
>  		ret = IRQ_HANDLED;
>  	}
> @@ -331,7 +335,8 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
>  		j--;
>  		if (!j) {
>  			control |= DW_EDMA_V0_LIE;
> -			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> +			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) &&
> +			    chan->irq_mode != DW_EDMA_CH_IRQ_LOCAL)
>  				control |= DW_EDMA_V0_RIE;
>  		}
>
> @@ -407,10 +412,15 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  				break;
>  			}
>  		}
> -		/* Interrupt unmask - done, abort */
> +		/* Interrupt mask/unmask - done, abort */
>  		tmp = GET_RW_32(dw, chan->dir, int_mask);
> -		tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
> -		tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
> +		if (chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE) {
> +			tmp |= FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
> +			tmp |= FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
> +		} else {
> +			tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
> +			tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
> +		}
>  		SET_RW_32(dw, chan->dir, int_mask, tmp);
>  		/* Linked list error */
>  		tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index 3080747689f6..53b31a974331 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -60,6 +60,34 @@ enum dw_edma_chip_flags {
>  	DW_EDMA_CHIP_LOCAL	= BIT(0),
>  };
>
> +/*
> + * enum dw_edma_ch_irq_mode - per-channel interrupt routing control
> + * @DW_EDMA_CH_IRQ_DEFAULT:   LIE=1/RIE=1, local interrupt unmasked
> + * @DW_EDMA_CH_IRQ_LOCAL:     LIE=1/RIE=0, local interrupt unmasked
> + * @DW_EDMA_CH_IRQ_REMOTE:    LIE=1/RIE=1, local interrupt masked

You'd better descript remote interrupt also.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
> + *
> + * Some implementations require using LIE=1/RIE=1 with the local interrupt
> + * masked to generate a remote-only interrupt (rather than LIE=0/RIE=1).
> + * See the DesignWare endpoint databook 5.40, "Hint" below "Figure 8-22
> + * Write Interrupt Generation".
> + */
> +enum dw_edma_ch_irq_mode {
> +	DW_EDMA_CH_IRQ_DEFAULT	= 0,
> +	DW_EDMA_CH_IRQ_LOCAL,
> +	DW_EDMA_CH_IRQ_REMOTE,
> +};
> +
> +/**
> + * struct dw_edma_peripheral_config - dw-edma specific slave configuration
> + * @irq_mode: per-channel interrupt routing control.
> + *
> + * Pass this structure via dma_slave_config.peripheral_config and
> + * dma_slave_config.peripheral_size.
> + */
> +struct dw_edma_peripheral_config {
> +	enum dw_edma_ch_irq_mode irq_mode;
> +};
> +
>  /**
>   * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
>   * @dev:		 struct device of the eDMA controller
> --
> 2.51.0
>

