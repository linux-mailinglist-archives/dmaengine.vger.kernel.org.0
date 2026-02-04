Return-Path: <dmaengine+bounces-8726-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBmBOR9fg2mJlQMAu9opvQ
	(envelope-from <dmaengine+bounces-8726-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 16:00:47 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F3839E7BC5
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 16:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 951A73022C25
	for <lists+dmaengine@lfdr.de>; Wed,  4 Feb 2026 14:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDE24218A8;
	Wed,  4 Feb 2026 14:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="X00y5OtB"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020123.outbound.protection.outlook.com [52.101.229.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCDA4218A0;
	Wed,  4 Feb 2026 14:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216894; cv=fail; b=bVC9IgDAOJWtJbTSBH5WNy3JQWYkSdjIetnliTva8hah+PnaAI0n5O5rwy6HaHup6NygsvWVvfuvtmfYvqr9CodUZi7tnbvVNK9PY/R8kQbdNmFB5cDNHXCU6GAVce20TLYCokVteZjFaTAL3zx+8rLMPgVKqVnqMtNgDhX8v6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216894; c=relaxed/simple;
	bh=hOb8BJF52xzC1qdBJ4+aCRZSGjiYxYSwt19mniN9Ihw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u7ct7G7QmEl/J69Oq5NRs5o0fM5y76flwskqLB9Nja88pXcCpypeE7vND78YicSCISu3OIpxuJYFAbxTM+2uznKahTTIt12MnJjG8TUQn/DZ1d9u2Y69IYtp0uXZmv3UNETnIGr9QfqTCINPt7MJcs2j+eoL4Durd9cAQ5KGqp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=X00y5OtB; arc=fail smtp.client-ip=52.101.229.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o43UG0gIsr5azsn/lFpW2RnqXhIeWtmXoI3HOO6XwnpNG5ieu8kVcAwWPaatg+OhF7cXLXxLZcgQyHSdigQOVAXy2KGWTO3AWQLEeFjWm34JbMxAOPjxSDhh2YPFkYBJTlc41n1KmqRp82TBwA4wsJYeHAQAyyaKEYUIZNjdABt1F1VVAGc2BWmVqHC9VjEH5+pLUGsTKErfsQrPYZVeWMQoYrLbv/wUZLg4hm7zD/4/Cu1jfxsEBIuHXL+3+sDpVVyzgVvH5hkbdJDk6GcOHLWzDqt5oyp/eozcsrYBT+QTP5c5HUHdTIv4ghkLJnKtGe2VtzWlXyhKk/7wLr6Eiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKdfx5WovNaRG96pDAjpKh03Wudln7z6ky0A68WDJD4=;
 b=dvMYRJri3NZFOl37i2QgowADG7c0BOsTnFb+mUFcbhJwt+WvB6O5KpJYEVyHTEK8E2/KLpJ8+DPqK4e8O++B07ymHWv2i77zv5Qu9juegAT4/2Hzvj06KsGqAEnZ8+m50O+DRBL/s4OC3WGlfbZSUj3OQPWHlGaWfFGj9ZcUOg3PnXlFPikrDa90sAR1VcE25g88LEafZfqVfAm2R3s6zhw1wXy4Gtc2nTu9gzXhrd8ElQkenyU5hzqC9srfxyPWUeO53IyTyaH6kn1QuQMj8QUcq/8PBlDFaDxOnWgDSTSZDazmunSZ3/3k0OU6KP5Ew5yl5ltM632Ej/Mhs6fMUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKdfx5WovNaRG96pDAjpKh03Wudln7z6ky0A68WDJD4=;
 b=X00y5OtB8ystuttCWBx0M5F0VMz+hXxwvunZf46uBsbqEnsZvXl1MGLFYlBUgMcFjaHmW77PloWTS/ldX0ovtB2G+9JWU/3tPnByantj2lFQ2YEcFRkAGmrCfpfYQ7CWR45lxt65DSA/YV3mnEYKKd0XEo8qaED0rNebf3SpR10=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB2976.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:302::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 14:54:53 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 14:54:53 +0000
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
Subject: [PATCH v3 08/11] PCI: dwc: ep: Report integrated DWC eDMA remote resources
Date: Wed,  4 Feb 2026 23:54:36 +0900
Message-ID: <20260204145440.950609-9-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260204145440.950609-1-den@valinux.co.jp>
References: <20260204145440.950609-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0025.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::16) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB2976:EE_
X-MS-Office365-Filtering-Correlation-Id: bf807f9e-ba65-4ec6-96a1-08de63fd5ad0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CGAHa5HkiXCci7FwOT78Y9RYUHvPycnWUVmzUJbxFXpQ+uHFWU0GJmyPziYG?=
 =?us-ascii?Q?+H9QFVWiHT2ZlZhIKujyNsLkAjxPd9MQynlTdCMRBF+rlYbbU/ZZyHJ0TMg3?=
 =?us-ascii?Q?rhVRgE99ETzRQjuwZoYta2fxwMdn2E4eJkhOMSBAq6p593hadAHFtx7FioGy?=
 =?us-ascii?Q?lWBCysbp0p15mPiKxG8yicZqw03Vs/yTGnhjwbd3rQC6nXnmfKGA6F8MTYjs?=
 =?us-ascii?Q?TR+OF5FanyXjFYaK+ZhX+CwmLOw3kgYUqar2PzJP6znKTItr7ZGN9ZWThrBU?=
 =?us-ascii?Q?HghDdbOpQ51FpfAH7jMqm26nJug/IU5ACOctHB0ZWMONpjkVmfKeBcJ2M54O?=
 =?us-ascii?Q?pcqaXGxHpzNx2EihhISl0YG4HBL9j6F0jH/OEq7OGdS9ixF28DdjezLlRAJa?=
 =?us-ascii?Q?mP5LNVvQfHzCaudiOUe/QOaXgHvlKEFCR5HVoN46vko8J2Fcn5CegTIWoQcN?=
 =?us-ascii?Q?YUT3jQ0NKd/7en8uilmCpuiWVNzkrYllMjPUgF76iR9ONHcXleKy9NK9a7Z8?=
 =?us-ascii?Q?AUrXCpU2eTWgVnLfMrdgqWBSr0askSgX/D1XJhw6yEuY8TjAH5YzP90Mz5MI?=
 =?us-ascii?Q?/eN84JIkxJkCu7ti4btK7uvNUNjZuyNUjhSx9QLcP9u5LB9iEDWF0mfIp7LE?=
 =?us-ascii?Q?uzcB7eQ/UGMdZ9E74J0pC/en311+r7amKifXSLHESRXZpH1+V+n7nwoBJaSM?=
 =?us-ascii?Q?xNbTZqGwHoP2QtJtCUR1E/rE7VWfpJfSCjmbCHjqbv9vcOhC+9OyHyhGiTDd?=
 =?us-ascii?Q?Mv3EMCeW0wLC+bTh4odu1UA3za3qh5YD41ggnPFM8Gfq3+Mz9kGR0ft+xu0s?=
 =?us-ascii?Q?v/8jVlRchOE87dvWqZE5P0kqXyHb9lqxTq7PQviM32B+OHUDujkvPM35VqR7?=
 =?us-ascii?Q?3cErpTb/ZTW9ACY5hZbiuIFNDn3bdGy5t5ZCXe0+IuVk8CcFckLbroOqkTzS?=
 =?us-ascii?Q?o4xh4YInMZ/iRGihcD14MVcSNiz5am90q1pGZFfLkB7+U3sZ/RZIqPKbaI5G?=
 =?us-ascii?Q?spAcq1C5biOGW9X9HbR71uIYlZPzv3ed09623yeFaUQ1rIiUoPdM+rXZfOxr?=
 =?us-ascii?Q?H4b0cuSN8DegyR5npOz/sS5zguZqVSY6Fa+rb/IurVRxtWxLxkDMVpb+0Dvf?=
 =?us-ascii?Q?NeoFXm/PINA+O5URKQV71C72zncUZhqfI3a0WpKFl1X5zDtM1OKaqp2CkkJW?=
 =?us-ascii?Q?kKGPanePb0griygMc0KMlwuS1RN3NuFGdZL/G6WVKPssovl9sh9qC3RWoatN?=
 =?us-ascii?Q?HhV3TLVXDoTec6hhVOtSqmDe7cwyVj5v++Nc2iiNXcn6l19Nm1aYeikEvHwX?=
 =?us-ascii?Q?f42NymJaLgeBRE6r6LAcyYGlcyjfT8Y75S528WmCSi9IZO4VafG17jdVL59l?=
 =?us-ascii?Q?ciZ3Oc19RyvsoLTLoqT7GohmtESvkOyiok0wXP4Bt25UUeIl4pbVFzEN3v3C?=
 =?us-ascii?Q?d5nbWOdaSOhp/etJhLZ/ZW/oLGlHxr48zYiJZxRjI8zhNAdR472ZlaSL33O0?=
 =?us-ascii?Q?JK7+C3l2F4iZL+xur5tQcX0z3ws9GxDg+r4nMbvDZUluI5MN35/cBJXFPJnr?=
 =?us-ascii?Q?Emcx+lW8B/Y+2VdIz1s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4gaqxCxnzvx+uKS+qlIFhboElvvtcNRMXJkL7b/yc1LLWgOfIDaZSpHDRyRv?=
 =?us-ascii?Q?hyxlto1L7YGmVHrPwBsHt7Tqu5bf32Bq2WBe40pcgKA7o35ceZRdj4sqoO6N?=
 =?us-ascii?Q?ESd75TmRx8wuvu0bJDjGVdsdlWeINSA2PTng7V6R+pNW88AyUHC1GtFMGxL5?=
 =?us-ascii?Q?/Pr1RYCoL68nGaKgGwrO9EoW3q1z/TCEWDx3esjjjhFnbvkF72EJWlRKP3fm?=
 =?us-ascii?Q?php4AX+nmCJ9AoORMvrH8iUPiTpcPoE1c79Z1Z+5wS08X2TMlaWuzdz4n8Rj?=
 =?us-ascii?Q?9O9fAjc4TGmfSyDSV8NH3u6Ij+EDFZbVp1O00cUqz9Q1JKTxI5ePCziT4MTQ?=
 =?us-ascii?Q?7WkRbm0rouOPE69TfXSFY8p7KLHjB3Ym8OPqNSJyFuejm7CB/1/1ntSyt7/q?=
 =?us-ascii?Q?lBssKMPvs20tXSQTyBdohDs74GHd5wXSXJ2XIsmNQVLANlHMiZNHbUv9Tu34?=
 =?us-ascii?Q?DDYkPj88hBhLAwsGTXxD/6vJIqVq+IUiD/Z6aHjLZyhM4Hu+zsrm84oSzJwM?=
 =?us-ascii?Q?Y+JnT/40NHnlNHvjeh6ctdjwQ/5sMV4zGy/KI8DjTV/XjenZYE123Iw7ho/s?=
 =?us-ascii?Q?15efnAgOQzKBAMziOzseT2t0L3uB2I5GQ+XP9XHNZ8CU+4XkAgTEUzPWDDUT?=
 =?us-ascii?Q?KamS2KGLGLWHz70PehIhasjxLCMcTbIRK9aAzKicOJEJM6a3cKHV48qrlipU?=
 =?us-ascii?Q?TSo7kjB/PlZqVsRSZhKNIpdhuKAuBaE2kBbi7I5rNiqMh1zVAE3MWH5ENzeW?=
 =?us-ascii?Q?rA43Fzsn63Knjo3TsErfmCoKsw7muBT7mgN2pwvisZ+ezgwnjH9ZlqpQEF28?=
 =?us-ascii?Q?/XIlRXE8tCxMkB/44alBzUY70G0r3U7Mac79GLsLR5ljjWGX2FKlPashydXM?=
 =?us-ascii?Q?XF2d6JpQaCWeo0s2UYZAXqHCXVfqRCo9hJBg8AxDc4/LwD9Iz9KlqiGP6lBE?=
 =?us-ascii?Q?2sXAoqyngEC+p6FW17MixS6S5wl92hD2swzCaTtKWN49kzP5EWypplT+vbp5?=
 =?us-ascii?Q?oGtj1DO5wzyPu4sUL3NM/xqc2r1wb1Sp5E1ERJjeF5yv/8Tt0iIwWFwuYcgn?=
 =?us-ascii?Q?yog6xlPo21jhuGReObnayX1UK1TK0o0dqfhgu6d7DbEEBl77pRkou8S8iGgo?=
 =?us-ascii?Q?vGreuE5Wf5qRtOQTfocxwwjykYxD176UJE1Ds252XIGJaStYlBvDlU5CtfcC?=
 =?us-ascii?Q?dbQoJA9tjBF8vhfpVHd7zdA1dDmZ4lR1arDz5UwI8L+1/pXTIC9IAhPz+KXn?=
 =?us-ascii?Q?nagDw7S0ZX4vF6ki+aLLRTGXyNKNfudfRRphZvxEqQvhnCmhbX6uVpe8qPHL?=
 =?us-ascii?Q?zRVii9hi0zXUwMwynsgvbA5AnXOyueWoZRD9LMRTdvSf7bOLsnYhfksTYddO?=
 =?us-ascii?Q?nMZcy4G4A1srL+oVAH+cqbBRzpZycZuUi2khnG2LM+hpCkJuMxiisilgVs3R?=
 =?us-ascii?Q?T1/dVCmimxEX0zPUBB0h6uBqhAF1tE7Iup5x/mEjb9Xq5IB+wxe7kQnY2iI7?=
 =?us-ascii?Q?aJLlnlF9yKkKkQM9qS47n39KXNFc7iejF59nkovh11Kz9aPe8AIzJsGkvc7N?=
 =?us-ascii?Q?AZTLgur3BBNlxdjUSvIwylmkLIGe9AVl1k6D76NWFC/7z4M/P3mq9yAvLhI9?=
 =?us-ascii?Q?9i9TMaRPJ8bpOhKb2GBdg1M8khgS5w9gz+5HSvt96zZ7LNN1qsG88X2InJLE?=
 =?us-ascii?Q?IsTHzIPxd/ZLYoFFOHaj1PTkMcH24QyAamukak6fPAQLz/9SCscXlfKm89+g?=
 =?us-ascii?Q?hgKo1wi7hPIPcFEpiTAgJsyK1mnA58LMy26G++4/0kI60IfRhfy/?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: bf807f9e-ba65-4ec6-96a1-08de63fd5ad0
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 14:54:53.5099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oILX4gtWMChoabSeaIfFE5vm4+3iXSFUIaerFh+N2ZWbBJV49EzF1XBLe3C3yPstO1wA3zm+aKdE6/8ru9EGHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2976
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-8726-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,valinux.co.jp:email,valinux.co.jp:dkim,valinux.co.jp:mid]
X-Rspamd-Queue-Id: F3839E7BC5
X-Rspamd-Action: no action

Implement pci_epc_ops.get_remote_resources() for the DesignWare PCIe
endpoint controller. Report:
- the integrated eDMA control MMIO window
- the per-channel linked-list regions for read/write engines

This allows endpoint function drivers to discover and map or inform
these resources to a remote peer using the generic EPC API.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 7e7844ff0f7e..5c0dcbf18d07 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -808,6 +808,79 @@ dw_pcie_ep_get_features(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 	return ep->ops->get_features(ep);
 }
 
+static int
+dw_pcie_ep_get_remote_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+				struct pci_epc_remote_resource *resources,
+				int num_resources)
+{
+	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct dw_edma_chip *edma = &pci->edma;
+	int ll_cnt = 0, needed, idx = 0;
+	resource_size_t dma_size;
+	phys_addr_t dma_phys;
+	unsigned int i;
+
+	if (!pci->edma_reg_size)
+		return 0;
+
+	dma_phys = pci->edma_reg_phys;
+	dma_size = pci->edma_reg_size;
+
+	for (i = 0; i < edma->ll_wr_cnt; i++)
+		if (edma->ll_region_wr[i].sz)
+			ll_cnt++;
+
+	for (i = 0; i < edma->ll_rd_cnt; i++)
+		if (edma->ll_region_rd[i].sz)
+			ll_cnt++;
+
+	needed = 1 + ll_cnt;
+
+	/* Count query mode */
+	if (!resources || !num_resources)
+		return needed;
+
+	if (num_resources < needed)
+		return -ENOSPC;
+
+	resources[idx++] = (struct pci_epc_remote_resource) {
+		.type = PCI_EPC_RR_DMA_CTRL_MMIO,
+		.phys_addr = dma_phys,
+		.size = dma_size,
+	};
+
+	/* One LL region per write channel */
+	for (i = 0; i < edma->ll_wr_cnt; i++) {
+		if (!edma->ll_region_wr[i].sz)
+			continue;
+
+		resources[idx++] = (struct pci_epc_remote_resource) {
+			.type = PCI_EPC_RR_DMA_CHAN_DESC,
+			.phys_addr = edma->ll_region_wr[i].paddr,
+			.size = edma->ll_region_wr[i].sz,
+			.u.dma_chan_desc.hw_chan_id = i,
+			.u.dma_chan_desc.ep2rc = true,
+		};
+	}
+
+	/* One LL region per read channel */
+	for (i = 0; i < edma->ll_rd_cnt; i++) {
+		if (!edma->ll_region_rd[i].sz)
+			continue;
+
+		resources[idx++] = (struct pci_epc_remote_resource) {
+			.type = PCI_EPC_RR_DMA_CHAN_DESC,
+			.phys_addr = edma->ll_region_rd[i].paddr,
+			.size = edma->ll_region_rd[i].sz,
+			.u.dma_chan_desc.hw_chan_id = i,
+			.u.dma_chan_desc.ep2rc = false,
+		};
+	}
+
+	return idx;
+}
+
 static const struct pci_epc_ops epc_ops = {
 	.write_header		= dw_pcie_ep_write_header,
 	.set_bar		= dw_pcie_ep_set_bar,
@@ -823,6 +896,7 @@ static const struct pci_epc_ops epc_ops = {
 	.start			= dw_pcie_ep_start,
 	.stop			= dw_pcie_ep_stop,
 	.get_features		= dw_pcie_ep_get_features,
+	.get_remote_resources	= dw_pcie_ep_get_remote_resources,
 };
 
 /**
-- 
2.51.0


