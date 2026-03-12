Return-Path: <dmaengine+bounces-9414-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJQqB4Als2nMSgAAu9opvQ
	(envelope-from <dmaengine+bounces-9414-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 21:43:44 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8580B27979A
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 21:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24F4030B1720
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2026 20:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97576322B6D;
	Thu, 12 Mar 2026 20:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CuWAQi4C"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013020.outbound.protection.outlook.com [52.101.72.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10763346FB3;
	Thu, 12 Mar 2026 20:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347993; cv=fail; b=KYBIqOuq2uaQ/pyukbOXYsJ/VsNDHxC5mt6GlVzdYUCxgJEA90X44btXnNpqjQe0txoWz/gcNkCuLTu2dADxSTRiIdVAGqgNFrfGYNV86C/ZnfpHW7BIT7EKqkWQEKNDkaH0k0OnirUh7ZNQHHBFK0uWt9XAN1cYRl8HhneOJkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347993; c=relaxed/simple;
	bh=3MN5NtNqiCYMI2iXnWpYwrQNyEQL2f+5BOllyns7lHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FaZ+8PwhuMCaknWmQk8TGToy0QkVOGf1S/oBnf/Qunaf2b7KeJs8ojxGKY/PIl7EY9poXglB8qDch2EPzru5MfscTmnTYt+EgkpLP2pgdUYBUrfuknxJGiN/ts3uUZbwT8PQ7rX+tJ9HOsAOLYfiMYF/MOJA384IwFKKw7pVVEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CuWAQi4C; arc=fail smtp.client-ip=52.101.72.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DzgBE9baPlfr7oc5xFJBSsGa9K00VwC5R/GRbcFkA9c259McAJkLdvS5xcn+6uxrqtee3vSPhActPu3PrM1XDWs87WxTXANHNNNPZyTTJVyvqX2Nt/z5qnI05SSYoTB40zeUbQm3XHnMPbtFwDJy/BnsvMtbAwFE7w81Hf6vJ31JCSzlKGJGLoL09h7jnf6mTzPJt/zhrlgF+XQ2YCy0gQMhw/4u0I2T48Ap4tLG24ee73a4llS59atIGmeK+V4hwJS6+cIzGsoz4WGKmBACQJWNsW+V656zQAV2vMih3eoL82h3sn4NFcsoHeB3mkYn2fcK5OyVo1AiolmiaElzQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzuUDLf2OUkws102eQLiR7Uqbeg/q34TLu9hDFL7Fo8=;
 b=aNMqdgk9SpTe26Ml7oPZZKvjuoTkRApg9CNHwMMCBJkhQxkAnfsGieeI5b32WIJgK/r4ojEEgXScCXf+J73OVQe4jggLQmNUwj+zSYsdh4Xc6CvT+rxFIaivIJRGqGA1l1yvmCskUc6QRYt5Ul93/TQk7kQEf7D3AGXf/GCyoVshPUsEmI7peLAmwUZDij3Mm6OwrtY6SUiB5MmVtmGwzzruipknUwfUVb0DD6pUoelWz3U+bptFm+niWT70rdEyLQEbGTzRrgEd5CsgeE5hgClo+9b9y325t1ZW/HvJB9DOSLwU6Wo+jeeO4kD2IDa4Dr7+KTqz6gaQJtUQEMrfxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzuUDLf2OUkws102eQLiR7Uqbeg/q34TLu9hDFL7Fo8=;
 b=CuWAQi4CndVkCYth/q0WV1AEUQkqY12CbmAZ4WP+n2/HvAy+YzlvpzCOSmD3DZRzc4yLHe3SiGxtL3oT4MFg+Uf1SAZbPIvcSZ/oEJkl9e+yxyuvUkiMYW3J2geGRzKkAKk9rvokmSPXg2qcq5+91TT4UlnLc7MtnWS8cDB9avcA+ggXLa1a1jQ2ytBsb8PoA/cLjVazKoYiF9wRAgEn3/u3h+hfkZbj3jGr9sWmfsGtTF5+RZCg6Ma8IWTLZVV2eSFAhjIMfG/RAI3eL+Ej0hOyQTH6jmqCeR0swWFE7hYpnBBJKjmBAEL2I96vG9+MRlYy7tQWtuUAn9pgS4PcWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GVXPR04MB10303.eurprd04.prod.outlook.com (2603:10a6:150:1ea::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 20:39:41 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 20:39:43 +0000
Date: Thu, 12 Mar 2026 16:39:34 -0400
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>, Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Baruch Siach <baruch@tkos.co.il>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH 07/15] PCI: endpoint: Add EPC DMA channel delegation hooks
Message-ID: <abMkhs4Ommy8P0D9@lizhi-Precision-Tower-5810>
References: <20260312165005.1148676-1-den@valinux.co.jp>
 <20260312165005.1148676-8-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312165005.1148676-8-den@valinux.co.jp>
X-ClientProxiedBy: BY3PR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::7) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GVXPR04MB10303:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f319259-49bd-4b71-937b-08de80777dc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|376014|7416014|38350700014|56012099003|18002099003|7053199007|22082099003;
X-Microsoft-Antispam-Message-Info:
	MqMNJV1G7mtrnKVS5qDkhwMQT2pUpRggM+fLI0It3mRE8AKlLpug3vZ8KIxwDJQ4TbL0PcOK4T6ogOmgb6BrEwiEWnXinMjD53Sdqwo8CjX7h/XAwp0ddgEzmE66xHzgzuunQRzl8v6Aiaxb0vI5CkuBAqutPAKov5OWT8l3DxBqTG7kAz0iJP9gVw/Fr17MKAyLi3IH7rKsTisOOVGhrtUiV08ajwRjXG8re9mXu9SFzgO9oKi6iwkhfoPrKP/ETkdlRH+AoPouznjPtPxZTd7gz248yCuYaB4N4YDlngKWXi8YGpmgwAlMvBaZGaM3JK5Yyq5NgLpSz/YcA3bpgbPXzN8RdrrBk0kFnIZfGRaOoWFfmqGxVg9YfIm4ynrXlRbobbC4zHDX5l0+qnwaXdnHGMh3H/oGfNXsyudvYFs+AZCq+Z3gFX6WnRncUIAQFtwMKjfg5kytP7AfM6KQ9aCMrT60N/k32snF7LU/1jmBoF8OEgA1UUniRnN3Jr2MPLpLJT+1riMe0WgpKw0DFLzt/KJiNGKQMfJ8Pr98xNtl2hpTNTJZQm7CxFrEhKuFURaZQk54YdGwoua7+qDV8wv+kc9ce9e2pc/s/Uy2+dUcblx+/9sFdzQ/9twKKSzf91NLZHHl85RGxpNTWPNKnYfF2lT3TY7Dyr6/bK6bBP03GKsFRlHYKTDb9pH6hsiNYS2kfycIM27Cfo+IflbWJRQUIiGbwFksopb+S/RLqh2DpOpEYuXUM4JgZ6pHdaRhPiCpznrNwsH4EhGbmLi6hRAy/Lbeic47aeZhHWxsGOQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014)(56012099003)(18002099003)(7053199007)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BXWCWnbksXjcDlg7wLjy3P3WaY659lJ6kciXTwDkLQ8C95MjNtVryNQu8APQ?=
 =?us-ascii?Q?gC95E3SWK17b1Z8DdWwiMJUxP8iXXQrwIOV43yRyCozvEZVbnnRGOzk59z+B?=
 =?us-ascii?Q?F0ChxW281Auna2O0Q49yH4J4WqZEQqj6yJDKsyhcaHvfq8KM130b0PJgb/fx?=
 =?us-ascii?Q?hhkaNX1c86ghiaJ46Cu8hMA9AviC7kFqEqD/Sp5tUxh5uRtIvg61RYfS9G5a?=
 =?us-ascii?Q?ISxc/O2PymMEiL2FbLWQ3x3VFwhLR9ZQXDknUM8OrZHWWBW9JoIx8BfnSpw8?=
 =?us-ascii?Q?+liUf1AjhVQzagijE+6T2RneFKm/K5bmEwNhg56ZFE7M1LwYoP751Uk5SBSV?=
 =?us-ascii?Q?5indVfqV2B0ToDJPZrovBA9YmrrFf3BSRWUpsZn+p4zn4ng4ko0D11nX3Vn+?=
 =?us-ascii?Q?rdf4Y018p4n9xzjOZfFRI1Ih6r4di19EVnCqN2/XQOoG/qcdhTuljdIMBOjU?=
 =?us-ascii?Q?i3gkH9pQlSofweaOlNNx+xdcIiSpakYMrvaMNIGDSfMNtCi7a9XOVRXMUeiB?=
 =?us-ascii?Q?crBvakj50t2wIEuP4es2909MjReHfAzzgYv3pl2Vz23s9oToIZABJiICAuOt?=
 =?us-ascii?Q?GySgtB4I8e3KdgjfuTmazNNKoQaXCjpNRdqRZuWzZWtCEJ3PpScvuBoMFtBP?=
 =?us-ascii?Q?pqGz6Vq7MbLspa/WAtag/Z1eEGKcrR7xJnfcWZBByx52EmDWDjVWmqtaDkBm?=
 =?us-ascii?Q?mSVWVW2CQboAPVQu7P0Htro9WykkIdNDHV1MzvWWws2EdTGmUCCYMU7JJBOO?=
 =?us-ascii?Q?aoukre/UR/FDn+91Jsfz5KzsS382KTKvkM/G+EuoJaonM72gMuIrrovyTHgp?=
 =?us-ascii?Q?WibDBMD/huAdNoLvkkwNSKP6i8JGYxjbBvP0XmbX09Y5GVQ6Slfix/jAnQnl?=
 =?us-ascii?Q?gww12+T1qJEiroPB7vjQ8+4ll1pM713IDd5WxMkA7KB/ZlF+nZJUcBgBocrO?=
 =?us-ascii?Q?cRJuLg+LHdWGLlCcHaVSpFbmJDDKEN7H+1wAYoFTFv2ACKnU+tBzhYU1hbGt?=
 =?us-ascii?Q?C3A1ogGOnkjffjFHIZT3QG2DiOtW0bhG7Zolfi2f434d9RnFLcCM31oNk7c6?=
 =?us-ascii?Q?q2NfzcXK6OE8ldkFhicVztsp9qSzY40TLBBY+XGM8oYwPKAfGkTKI0IbPBUZ?=
 =?us-ascii?Q?g012lO7MGnQWeWSP1ejQiCKcp4ZCHlMqlQObcqfkUF6kgRonP8ooxb8oZh0r?=
 =?us-ascii?Q?U40Sm7P1kWJ6DH/syeOu5/NPlujLgt1+lhhWcuaTD8EuXuEJwE1sHJ0eDLox?=
 =?us-ascii?Q?rspshJ+DZVVWj5Si8C/qwnqNW9Ysgestp/ra8rZF33HUwXNb2L4zsWyjxS+/?=
 =?us-ascii?Q?rpNTp1+4WgomJ2Pnr/tZFOByArbMEFM16L6hxa30Q61jb03pv6tnXZziigVu?=
 =?us-ascii?Q?gOv+Hfy3tAry7DadER/9zFXaTosUS2aIJg1OOGQe+i46CFFWjuCBnavXdYik?=
 =?us-ascii?Q?wR7jfOGVO7AU1g8p1DhbY6hZr+l0A6w4W2f4cE4U55NeQcNTUvkX3hDFWKTq?=
 =?us-ascii?Q?4QvO9rbdGn8BfGUmfV+L2Ult7DvPczN01+iypog95Afc354URd7eHWlOPNSZ?=
 =?us-ascii?Q?EVIH9sXWbnzpq/WO6vF8qYRmJLA7BG5YmrEO5gMF2DyEe5XEgdUkgwYO5LMj?=
 =?us-ascii?Q?yZHJzTwrOx/dQU+zIwZWH1jaTTIJ4fiupKEsK+LOyvW8p8du1FwWnWd0lM5z?=
 =?us-ascii?Q?XvULweJzoIlrXhhOaBMe9z3Z2B07hkejIneAUJWTOh7dCBNv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f319259-49bd-4b71-937b-08de80777dc7
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 20:39:43.7617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 67Gvv5HTnxsbopffoIH4iqao2zeOtGwTZ0c1PIjYnbLyawXkhUTKnJHkm9VKEAXarmq7X5ZoqYsNOF33yuJGKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10303
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9414-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,google.com,lwn.net,linuxfoundation.org,kudzu.us,intel.com,gmail.com,tkos.co.il,baylibre.com,vger.kernel.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8580B27979A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 01:49:57AM +0900, Koichiro Den wrote:
> Add EPC ops and core wrappers to delegate and undelegate controller-owned
> DMA channels.
>
> The exported DMA helper needs more than a passive "delegated" bitmap:
> it must be able to reserve channels away from local users, let the
> backend perform controller-specific setup (e.g. prevent the EP from
> racing to ack the completion interrupt for delegated channels), and
> later hand the channels back as a matched lifetime operation.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/pci/endpoint/pci-epc-core.c | 84 +++++++++++++++++++++++++++++
>  include/linux/pci-epc.h             | 19 +++++++
>  2 files changed, 103 insertions(+)
>
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index dc6d6ab4ea1e..892f7ccbd236 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -197,6 +197,90 @@ int pci_epc_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_get_aux_resources);
>
> +/**
> + * pci_epc_delegate_dma_channels() - reserve EPC-owned DMA channels
> + * @epc: EPC device
> + * @func_no: function number
> + * @vfunc_no: virtual function number
> + * @dir: DMA channel direction
> + * @req_chans: number of channels requested
> + * @chan_ids: output array of delegated channel IDs
> + * @max_chans: capacity of @chan_ids in entries
> + *
> + * Return:
> + *   * > 0: number of channels delegated
> + *   * -EOPNOTSUPP: backend does not support DMA delegation
> + *   * other -errno on failure
> + */
> +int pci_epc_delegate_dma_channels(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +				  enum pci_epc_aux_dma_dir dir,
> +				  u32 req_chans, int *chan_ids, u32 max_chans)

Use bit mask should be simple, bit 0 for channel 0, bit 1 for channel 1
...

Frank
> +{
> +	int ret;
> +
> +	if (!epc || !epc->ops)
> +		return -EINVAL;
> +
> +	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
> +		return -EINVAL;
> +
> +	if (!req_chans || !chan_ids || !max_chans)
> +		return -EINVAL;
> +
> +	if (!epc->ops->delegate_dma_channels)
> +		return -EOPNOTSUPP;
> +
> +	mutex_lock(&epc->lock);
> +	ret = epc->ops->delegate_dma_channels(epc, func_no, vfunc_no, dir,
> +					      req_chans, chan_ids, max_chans);
> +	mutex_unlock(&epc->lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(pci_epc_delegate_dma_channels);
> +
> +/**
> + * pci_epc_undelegate_dma_channels() - release previously delegated channels
> + * @epc: EPC device
> + * @func_no: function number
> + * @vfunc_no: virtual function number
> + * @dir: DMA channel direction
> + * @chan_ids: array of delegated channel IDs
> + * @num_chans: number of entries in @chan_ids
> + *
> + * Return: 0 on success, negative errno otherwise.
> + */
> +int pci_epc_undelegate_dma_channels(struct pci_epc *epc, u8 func_no,
> +				    u8 vfunc_no,
> +				    enum pci_epc_aux_dma_dir dir,
> +				    const int *chan_ids, u32 num_chans)
> +{
> +	int ret;
> +
> +	if (!epc || !epc->ops)
> +		return -EINVAL;
> +
> +	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
> +		return -EINVAL;
> +
> +	if (!num_chans)
> +		return 0;
> +
> +	if (!chan_ids)
> +		return -EINVAL;
> +
> +	if (!epc->ops->undelegate_dma_channels)
> +		return -EOPNOTSUPP;
> +
> +	mutex_lock(&epc->lock);
> +	ret = epc->ops->undelegate_dma_channels(epc, func_no, vfunc_no, dir,
> +						chan_ids, num_chans);
> +	mutex_unlock(&epc->lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(pci_epc_undelegate_dma_channels);
> +
>  /**
>   * pci_epc_stop() - stop the PCI link
>   * @epc: the link of the EPC device that has to be stopped
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index 7dd2e4d5d952..db8623b84c56 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -142,6 +142,8 @@ struct pci_epc_aux_resource {
>   * @stop: ops to stop the PCI link
>   * @get_features: ops to get the features supported by the EPC
>   * @get_aux_resources: ops to retrieve controller-owned auxiliary resources
> + * @delegate_dma_channels: reserve controller-owned DMA channels for peer use
> + * @undelegate_dma_channels: release previously delegated DMA channels
>   * @owner: the module owner containing the ops
>   */
>  struct pci_epc_ops {
> @@ -176,6 +178,16 @@ struct pci_epc_ops {
>  	int	(*get_aux_resources)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  				     struct pci_epc_aux_resource *resources,
>  				     int num_resources);
> +	int	(*delegate_dma_channels)(struct pci_epc *epc, u8 func_no,
> +					 u8 vfunc_no,
> +					 enum pci_epc_aux_dma_dir dir,
> +					 u32 req_chans, int *chan_ids,
> +					 u32 max_chans);
> +	int	(*undelegate_dma_channels)(struct pci_epc *epc, u8 func_no,
> +					   u8 vfunc_no,
> +					   enum pci_epc_aux_dma_dir dir,
> +					   const int *chan_ids,
> +					   u32 num_chans);
>  	struct module *owner;
>  };
>
> @@ -403,6 +415,13 @@ const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
>  int pci_epc_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  			      struct pci_epc_aux_resource *resources,
>  			      int num_resources);
> +int pci_epc_delegate_dma_channels(struct pci_epc *epc, u8 func_no,
> +				  u8 vfunc_no, enum pci_epc_aux_dma_dir dir,
> +				  u32 req_chans, int *chan_ids, u32 max_chans);
> +int pci_epc_undelegate_dma_channels(struct pci_epc *epc, u8 func_no,
> +				    u8 vfunc_no,
> +				    enum pci_epc_aux_dma_dir dir,
> +				    const int *chan_ids, u32 num_chans);
>  enum pci_barno
>  pci_epc_get_first_free_bar(const struct pci_epc_features *epc_features);
>  enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
> --
> 2.51.0
>

