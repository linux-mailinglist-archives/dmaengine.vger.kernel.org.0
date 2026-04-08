Return-Path: <dmaengine+bounces-9928-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AqSLm8I1mnbAQgAu9opvQ
	(envelope-from <dmaengine+bounces-9928-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Apr 2026 09:49:03 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 308F53B888E
	for <lists+dmaengine@lfdr.de>; Wed, 08 Apr 2026 09:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 013D3300901A
	for <lists+dmaengine@lfdr.de>; Wed,  8 Apr 2026 07:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221B5387571;
	Wed,  8 Apr 2026 07:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TEr+ADGK"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010019.outbound.protection.outlook.com [52.101.69.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D662C3845B7;
	Wed,  8 Apr 2026 07:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775634539; cv=fail; b=ZNxcsCupmAAyvvH1HoduUWoijnTFk5WPvinsVVrDTmwiMTNhgYabBZJOwIKJWz6d9GJY19GYOmfvPmpvygSnyhDCcodbLDlVFf72vj0DLsO5CDJobrMKWBXX0zqzDzIz2elrKIyqcXOBjH6fMAkDq4GY+CIbXEUiu/A+gQ/cK2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775634539; c=relaxed/simple;
	bh=8tJdbm3KbZ4+DQDXp7owwUvmWtr2Gjo0HaovC8OAKCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qYCKHzxBrFcXK5E2XnY0wh8SvZLJioeG0c+0cK4VHL4jCZ74SeAP4h5PApJLB1/+ZO73WYD0FACOPOdVXub/eVbjkDBVXwaO+njYp1dIU1UN2zYvNu90bg9N5PYf98mJI9ERyzMamElvUf5HSxQSRXNUQQ1Q+mdOtvKGM4mks4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TEr+ADGK; arc=fail smtp.client-ip=52.101.69.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fDyXxnq/C3NwmQNpL/Kt//usTAtAPXlRo9Wefj7Ns1XwShgwJueuUek8eRRJGZZd7Hc85IzjomcmQ31zzpsCDWfxzcgc0GgBqpTAQez+HH9cf2rOI/uMlGHSDrh/juBbECRhFTvxuBDia1XNFj+N1LJHfPs7H/IMIlyuDjyPigEqeRt4A3j6mCEm5BzjZs5WtlEsthZyl2td1bkD/3GqIWtny25uYec7RF36ua67zEMfG7mNLwLPNnoWJWvvq5j7g/kZ+wKFEbcaeRIjA9vzlXdyalvGTdeNUdr+Wlnv7jvnxd03872P1ncmglYOh7RAH3uA6TkIQGi9R5eNTI7UWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tJdbm3KbZ4+DQDXp7owwUvmWtr2Gjo0HaovC8OAKCE=;
 b=tvDVKJvqa3biCAPonddnLiNUhDSgGh4I00glSwW0Zu2uP/rcjgw8kF1lY0pPj4is+DfpjnMCkBRF7VuQRE5sLGaiZUD5UMecoqXkYsDtFwAGRM1WaSMm8LEtQjojKsUIH2SOUBTBLP9UDNxwEFp/voW5rFMxn7+bZoSLvhv5X8nNRXBBCqQmXcUs8RRAfbvv69FskwozGWD1pv42HDd+nsgHaP2WZYr6ovdvtRW7pOAVuCXDqdiTOaq7o9lvKr3LNsJ6Ik88eUOQVvKg24cTvZYM3DvFJx8dy219s/Weex+Frec7j3icit4Y/ctfbTDjmkVvCY0FdHzio/v16Q/tQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tJdbm3KbZ4+DQDXp7owwUvmWtr2Gjo0HaovC8OAKCE=;
 b=TEr+ADGKDoPDM84NePvHHzGI5oF5BwC4wf1RROSjB+5yuH3MH7hrwDdo6i+maEOoRT2C7lbG4j+EB0l8YdCEYbMMcYpqCQ00863nRqzLqxvrGhmLDkyvORqp/HruAafrTgJksSMOM6j6jk6Kejdn3Xs4U58wmLg0x1t1E1KPHRjzAXW9zX+xgb+Y1nj6kuWbGYXw9MTgS8ZKLpxZp+HUaIyo9V5eJ43rwRmXb+SKqACSFHErTQEL/80g2RyIjbu9BjcrZaQMD9PkZ8g7OYRf+wjKZCnubX2KJeNF1eaxCpfUnyVDtg54sbu2o7xujYFaGcTzH+CvHrujyAaZz1OpsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GV2PR04MB12680.eurprd04.prod.outlook.com (2603:10a6:150:36c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 07:48:54 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9769.018; Wed, 8 Apr 2026
 07:48:54 +0000
Date: Wed, 8 Apr 2026 03:48:47 -0400
From: Frank Li <Frank.li@nxp.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Vladimir Zapolskiy <vz@mleia.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"moderated list:ARM/LPC18XX ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] dmaengine: lpc18xx-dmamux: simplify allocation
Message-ID: <adYIX1QtfPRPynhT@lizhi-Precision-Tower-5810>
References: <20260407035132.99037-1-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407035132.99037-1-rosenp@gmail.com>
X-ClientProxiedBy: SN7PR04CA0188.namprd04.prod.outlook.com
 (2603:10b6:806:126::13) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GV2PR04MB12680:EE_
X-MS-Office365-Filtering-Correlation-Id: f554aa33-b19d-4f1c-03c4-08de95434835
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|366016|1800799024|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	W8yDcbHhrwEYZjhRRedO8/WojH5BC9/mO7fxvHahF6ntsyyB4JyFGFt8mYL3UYBmhRAFa0yditcAMDTA5X3iULmWJQzU7C8q65d5XttQI6rf2RhvTpYjOAeeMCCaZRN2Pcw429zwx54VoJGn+sdfDynE8f0u+2Hg7PRH8s83Gb3E0nZ1Xju6syhbTC26GvfJz2q2NIOFwbUFweHfwthIn0nxm57sRoGmFzn8QfvW9nO4PEZdW3RXfG7T2tsb43cT+xJm5PpoXi6Kdllabpyc2bIl9TXTYDlhcCi82t//cb4zU+savLdYqe1LbLtqyTeG5wUO6NhVn0uMZejKFtZff6cUrMK2L7SwHgSVn4ok5bzs8vAAWUsJ3Ei7SL8C2unBwbCuPGOLIZtSYapOXPrRgRgPXZ0LSVQP2dL8WzzlvtDwZsW8hNRPz9Rbi16CJ2dEpVM5e54t0Cw7I4Eijv792pqakFdXMrtj0YYlRYJ1VOVo90WGs7mvUhtLnKMSZ2nRXdpAuemNEsCHFPYvwticSWUY/af03nZRXU+plRqUDL/Ez7gd/GW0l4dpqrHlNhgLd4gqe9GjCqX3FYz7tp6CyewtTnMRfDjUBsq38i4Jq72+oFD3IfOqTKVs2HEv6UsosCl5DnnB+7HZDQCpEokOCcgtw0SOjDuFKgwzM2JJhBeYywNPUNSIdmYEhPTJ/FVCWNzEg/r11L6wqWH3LXfjbL0YqthtSNkabnbJu8rRaa6XfGKd4HiLRFPZfYKt4R9rNv02kQGJkhYtuqpd4vNZAiIEzPim4YQfjTocmszyQUY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dQtq9z+kJvHAvrA3tHAkYVhlE/LwoAfa4rzsk3V2sFI6oVvRpSe22jItAXtf?=
 =?us-ascii?Q?9jmpDBd/glk00DSgOUW+FeVSET7Wc6ESnZI8cvvHH/Kn5Zutn6DgVMxanT02?=
 =?us-ascii?Q?4RA6QztbUbWFprp0SqZZKplCc/5MoOW50BvsGXMWNdsKbJrPC63E/TKPEfa3?=
 =?us-ascii?Q?92xbt8uSEasWU12aRgb/mf3pTXAsmhY1rQ1/GFPiCG88TxlzlmOMKSmCURAC?=
 =?us-ascii?Q?AHAj+RVzJzLnW0i6+4aU48sgyJQg/I7vEQ5HkMhgKq6uJ+cpGMxpMnfS6f7d?=
 =?us-ascii?Q?zbNbMHtwrngPcK62tUvlTRyyUOerrZ71htMgovqTXwTTks5kMakQgjC+aol0?=
 =?us-ascii?Q?DQU1y/tuMlA9hwrx+3NTVYjbR6mjQvjJ0fDRBIWpCI424zpOu0iQSana8ul9?=
 =?us-ascii?Q?r1EfU0Iepi3GJiqP453B5n+pkTfhM8PpdqwgHu0UYgXCbaFf3CCl2/bxfGu+?=
 =?us-ascii?Q?OuZNvPT4GFDA0XSZABFVqHUf1jHkhIuNqAT9mjnoB5Sydc2Ma7pYNE2BqHbr?=
 =?us-ascii?Q?bXn8ZEg+ry64Qie/WrQIroZCLfCdwpzpsVp1dQ0RkGM8Wr8vLSp4raDTvHSD?=
 =?us-ascii?Q?S90pyRmFJNY1tIsJWnTrKkUwvP2vf/WOAZ2ISsARpXKedCNc3pKson73GaWy?=
 =?us-ascii?Q?jMAHW1gxmmcNa/VHA1yxiQjuR9Jg1thQnIkfUke0nJS54ddu8sUXrTeH3ih+?=
 =?us-ascii?Q?I8G7b2n8bzSlobkqV+9wDatzqpfQhWH9D3mLP6kvw4+TU5uQ9l3VQbLOODps?=
 =?us-ascii?Q?H+1gAv/cgB6y4bEQCT2Ouxfs1vtEL0P7ap53DNFZCL2QRFQ3oRQgwjw/ZTv+?=
 =?us-ascii?Q?fHoplADJma3iR/2eiucHppS742hS76mRy7Nn8feRiWoqWk3idYW4KD269YPq?=
 =?us-ascii?Q?Di9nFjz46+H240/Gj0j/MtWkKSXdn0qBEy6I3E/lsNZ/gUPoEhCQl3PAmULQ?=
 =?us-ascii?Q?+Rv+bgUHSbtcYZ2WLdRl7iaf3gaUgq/AfDyQRrYKfjcdJMaJOBA9iatL1lar?=
 =?us-ascii?Q?GCpSZ5c1Wlzgf0moSIcnEXrMGdXvRx++eL6QkC7lJiMakl9inR+fknHeU6V9?=
 =?us-ascii?Q?Zjqbl0MW6zHw5KCn+5eUDmkAFcbpYwTkYquglEv/EHk4paOFf9T1dKBWF6nz?=
 =?us-ascii?Q?/lmFQ4ObmbjRl4LAaXP19qQn3YP5GJgQ7ORKrEBxxGFrMPr3LdXmxiqLK0Qg?=
 =?us-ascii?Q?4y3xEbk2X4Sx1egZpF3bOsUqUz9ikpoP6ELCUxwSffP1OkUJhTS9fY830+M8?=
 =?us-ascii?Q?TvV6sT69RPILCFQmruibG4shD8fNtqIcL4F529MHTL00sCMNNRRvp0m30BRi?=
 =?us-ascii?Q?kvqL4MmUn5DcfG3r1wRGQaNWxIllie0x2RzMlhRhw9lc5jeBIMXRK0qA9Z8a?=
 =?us-ascii?Q?XdRnsYAPZTi2+lisniatDEnQ0h9V3HnzjCptsll0OIvHd+jzn4dX41MTDXc1?=
 =?us-ascii?Q?AT99o+Vc2Ip8htTbmRps6ZakEXxh/lBSy+uR2ATomRHO1N3b8zMe8mvaH9R7?=
 =?us-ascii?Q?0gLJRS0lo6I5SJzIHkk9WGl9G+6bnz8ukWE4cwY1M1gHZbwRfiKjWqad/+KY?=
 =?us-ascii?Q?JUWLFFz8mVylPHZYA68mQBvZySThk4mMBx1BGJNaYmdBuwi4cbFHJvADUKQB?=
 =?us-ascii?Q?wmGXDBxl7NvtkWlsuApiJyK+CUrv9cwMieWIkz0BTbkb7DayFL+rcXRXSqDZ?=
 =?us-ascii?Q?MYBCq+IU7q7kpCj/Pe2PyywS2CndSZ0GokY3+LHZ0MHk4P3hGlSkD8Vy10ZV?=
 =?us-ascii?Q?LBjvuTTofg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f554aa33-b19d-4f1c-03c4-08de95434835
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 07:48:54.1814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iuQHKTpvnHxQg4oVq5p8AomdX9kx2pNqdEFNgHI0jG1mEQ7Rlky9sMYHx9oANxr0v4XgdX296GRoYMBfx4QL8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12680
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9928-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 308F53B888E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 06, 2026 at 08:51:32PM -0700, Rosen Penev wrote:

Subject need descript summary.

dmaengine: lpc18xx-dmamux: use flexible array to simplify allocation

Frank

