Return-Path: <dmaengine+bounces-8998-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QASEConEmGl/LwMAu9opvQ
	(envelope-from <dmaengine+bounces-8998-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 20 Feb 2026 21:31:05 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDB216AA91
	for <lists+dmaengine@lfdr.de>; Fri, 20 Feb 2026 21:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34F4E3010515
	for <lists+dmaengine@lfdr.de>; Fri, 20 Feb 2026 20:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405AA2ECEA5;
	Fri, 20 Feb 2026 20:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CS044YiY"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013004.outbound.protection.outlook.com [52.101.72.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7A7264617;
	Fri, 20 Feb 2026 20:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771619462; cv=fail; b=pA5gHFNhsk8CqQ5yUzI2uKXCSj7gZ++xfGexL7y+e9p/Z2amnIw9WKk7yZYkm3Tpi+YJFD4oiZl/2+weYX9FI7ARC+D3qPI/i891B5Nw/uXNfDmU15zjKvoNlbv28Sv/9QlU/isOCNVaNkuhrC7JeV+GRR8XBa+Uit9KsDtby+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771619462; c=relaxed/simple;
	bh=ZtpFCwFs1/W50fsFFVpXsFqHo8c37sYHoBK+7EgDiTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=igQOg6gn9BTalZEd3cuYSJIJb65dkDDz7KILPVhO2ZES2oVLhJL9uGXIzuh//MX2u3xnykKBcopzmIXb8VV2OMFD9W9pAVaXCMkRvhJ5gIq9wpfQW+ETRgjm4zWUvC2fca2j5/yTFrk1mzuDJwTReAoQ3ODrvi21cfuzP/x7Px8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CS044YiY; arc=fail smtp.client-ip=52.101.72.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kkJo97lUKNN6cBdz/Fjy1C7JhiEgi5bsMWYonXbvtOIoaFKg8ELXA4zB7Sst6VsraOEkJZ/utc+UoFyWrQpGYdVfKvItUzryEVxIWB/rEeRR4CjvhqshkYoTpJlFWtLGcC0ZfnwCKjA76vB1PAVjRac62r/2Wags9e5Q2YNw4EvCbE48UQnJlw2SpVBrhRPIh76nTEOe3p4oHDvSagM6o8GMnUZ8e8E+/k6CiSvKdqP68jBPt9nbQ2oujigy9B2fdxaTvngW1laVbMobGqfnseFCbkcaapNV0KFgYbe3Zbd1zFcvfpeGqiDB6wWCPJ4YxRC16EV584H4k9REE8rapQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1kbcAbskTm9CkLruwYnV1hV23ED91BAIMWLfDz8kiA=;
 b=SzarUsoQyjwUgST9L2WGYzw+xDHmxq2hpSARtXYtFHdpO0iAFtUaOfxz0xZ03X7pqO6l9sm+m3aDo0EF4rLejg4hbh31uiM7/R07owjhseltl9nXWJK/94hCzWoj2QA5ITFyR1t6on4MvdAC615kFye6L3vvzBAn69SHvmYPfJqUNKJFIzWJ/GUc0Ncjpwg3yNGJHbB83e2lR0RWRiZ7OpM/AJZbcEEy9D9ZSJMukFPkL1vVNpyIiYXpxh06eXWcbxy5tNUbHxkT/t1LxEDGm0CFzyRCw7Yfh1oZlZT4c6lz/yK+/ENEu8/ueykxZcj9B/d2nnnKwoByxiUnc4po/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1kbcAbskTm9CkLruwYnV1hV23ED91BAIMWLfDz8kiA=;
 b=CS044YiYioCDh5DbxXfkp0DuurlPeihRHpg4s1kJUUcISJNhfP1dHm52laWSfNbQlKw614QUZ+etgoVBJBC5ui0AJg0eF+uu82dcD7vunG9rBj9VIxKg+y+y6y4EO3ikIHJYxWrHD5HnbzUqyVk357E9SFKoPJ7YfZGvjaplu8T5empQ8OtfPh53Y087YSORNUGQUj+ST/hvST5g+ewr1HhDWRBPNHyXRaSM5o2rGwRC7nU8E9/EX/k7t4rqYCJj4prlXpWCrPhen/aF/2LSpsrCXdeHtxSuw3Dz8EeImKEAb5c9sMTBl/YozjCCj6+9hCPxSiyeIJy+NQiy3AI0bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM0PR04MB6787.eurprd04.prod.outlook.com (2603:10a6:208:18a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 20:30:58 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.010; Fri, 20 Feb 2026
 20:30:58 +0000
Date: Fri, 20 Feb 2026 15:30:50 -0500
From: Frank Li <Frank.li@nxp.com>
To: Max Hsu <max.hsu@sifive.com>
Cc: Paul Walmsley <pjw@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Green Wan <green.wan@sifive.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Palmer Debbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 5/5] riscv: dts: sifive: fu740: add PDMA device node
Message-ID: <aZjEegxkIH3tqBo-@lizhi-Precision-Tower-5810>
References: <20260221-pdma-v1-0-838d929c2326@sifive.com>
 <20260221-pdma-v1-5-838d929c2326@sifive.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260221-pdma-v1-5-838d929c2326@sifive.com>
X-ClientProxiedBy: PH8P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:345::29) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM0PR04MB6787:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b87371a-f6ef-431d-9903-08de70bef4a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|19092799006|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IyAruBwfya+P9JjkYtJ47fPxhLZlBZHvXofHU36/v6G2IuFtKn8s9CqE/PeZ?=
 =?us-ascii?Q?lI3FfGij+/G4kxp8+AwOQwjL6ssyhhIJtILv7wrfdAtlKVjgokhPsUPh06tC?=
 =?us-ascii?Q?LCxgBdkBKPGqdMOGWHW3tLf8y0YzvLQL9qWV7MEluNSKG2r5AtGaPLdiQebX?=
 =?us-ascii?Q?jukLhg3YT/CHpzIUsi2blsfun5jMzqrlfZE+WdLaTQtNhFGKYBT1wxSCgVwT?=
 =?us-ascii?Q?XG19whyCzbYP2n031YLCeuT9l85nM14IzZGrJIkiXg0QATnXoZY7zG4j91YH?=
 =?us-ascii?Q?Xxl/9ztbhwZy4hWy5hRFpI+cJFFS8aeM1SjsQnQuVYvgaa3d3dXx2Deq+B6z?=
 =?us-ascii?Q?CjerSoVlBVO26iiW+ZTL7a7zbcSjSGIJrWLTm9x0hyZ0wHZaJ2NTOF2ubyfU?=
 =?us-ascii?Q?8koZvJNTl/FNxswGe/Lp4Iq2BJlrjvWtVIdhuQYi5S9ulaPNqkq039LHq49l?=
 =?us-ascii?Q?0sy91YVKFgA1T2mgL9QQbxDiDC5X+XWpb19AJCLRzTHPpW9Cics7Ay8vBhxT?=
 =?us-ascii?Q?fMQTIXU9PuFE39dcpVSm5ggVgxQfUUcFVKKH+XPaMIC0VKqN16pmDmBeRC1c?=
 =?us-ascii?Q?CDdRrr3Vcmy8Oz+uP+OY4QFJtm/sZVy9iwxef7Q9s6pg9CdgjEhe16H79901?=
 =?us-ascii?Q?DFWbVVHQwsbMAkPNmb8ebmq254IYUL3WBIcx6NPdYOF1mDK71cxjQ5EKpI4c?=
 =?us-ascii?Q?JY44BmXZLGEOm+JnEChA1Fwyi91Lc7w1UaLcNxUtVybQKwILhNvNs0olq2T9?=
 =?us-ascii?Q?811KWddajFWyBkKX0LoYBn3yI/NO9PPpWxEUgf9KwK/gPNKYDzYA4zeuaD7U?=
 =?us-ascii?Q?4VpxDm1reI6t3VMGDopC8SG+Up6IM/fvV6avHb0Lysag3MIehziE575sbPV2?=
 =?us-ascii?Q?LQQNDI08rlmev0PnHOxyQtG9vauQmCCZhhw5jUkkhQJQYHry5iD4qvMA+FZD?=
 =?us-ascii?Q?euKMfvRCwI6Ffgkj1OHctwmVbifuflRfzTigPJRBOH82I2qKaPcStSyzFPGb?=
 =?us-ascii?Q?GvU8y6oyqQi5hnFFh1ulFEAmBBcYVpzCxRi0++JclUpwR0blWN9cd4UWHhxj?=
 =?us-ascii?Q?4m79RhgCm7X6gJf1HLi+3i+72o/DEIg0kqpE5PGmPDbzGosewIbRAI3c2m6L?=
 =?us-ascii?Q?ovJR5II/N4/BDOX59hLtxamURpbABVVhYGjxD5ikIqtEbgbfB6JfY++Go9ve?=
 =?us-ascii?Q?4AWwXA1OmtfDRNQYeB+FGddxWt7gcMG+9xl1yRs25E4P9VCtdu+eBGJmcBhR?=
 =?us-ascii?Q?EtnpRqqB6G8HrypcEef8rAxmqb1utZgCy4UTljQ488l9acCnUwGSpBdh+U3Y?=
 =?us-ascii?Q?PVq3Y0CkpIhWY3WyWllqnQIIYzfbZSxvhROfoMi3htJGIIcDYXFf1ZW2caJF?=
 =?us-ascii?Q?opl5l3UxomM4wpmMHRytzmEW22BZqpnj0UmB/cRGr0rlWMNAg6XSgWq32Dlp?=
 =?us-ascii?Q?iNelhCtkWxmJVCYl4lvh6fCu7+kFjB8E6aFkbr+TjGYy0H0zd8xnjatrrBnQ?=
 =?us-ascii?Q?JYnUCioYqGWT+mQiU8FcmrkHG+6R3zWEkbsjUsGYBLk0rtxcLPnyMhg/UeVO?=
 =?us-ascii?Q?wEUDBDlllA3JYXALkzSrfyUClyBWyRj4Pdi8wMKcRH01kqn7QkzzrJqG3xyA?=
 =?us-ascii?Q?J7KpG5+c+j6jizunwnM/FoI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(19092799006)(1800799024)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ezitRQ8+wDaGj/pgJQI3LIQ85700C2VB9j0LWy+MlYP6XjKGsU86WaVgzZsn?=
 =?us-ascii?Q?nPPP2fs3iC9nOESc6LJtY4yENDyNTDsrT3CMz5ttaTS2A4HjgaeX/Ale+M1h?=
 =?us-ascii?Q?daY7qrlKLMBaxhnXaT+mX6m94j9vEepyDUIp41JyfJNd8kYLuYzHCjn1jSpK?=
 =?us-ascii?Q?1YmaN70G22cbQ+P7K+oOk3WSr9dPzs+VlQWZgGGOMivE9pAsYDNxDccfiBah?=
 =?us-ascii?Q?+E+3N7BeHxtSsxHyzI3sUYv/YZ/wkkqjUTSL08Sv2MZiINcwXWCCEmZdxbWv?=
 =?us-ascii?Q?+8tHuvw2gvcjpjzIC/CfR1tp/DYk7pxY3tVGTOem324QnyjReoLzU3hKV13p?=
 =?us-ascii?Q?404PWcg3jrB/HGYsSOK1G3K4+7CgULN7OX/GYqa4tEvAUC6NC5vicgWkp32U?=
 =?us-ascii?Q?x0zUjAZkZlaCHB2+fQ1d/2AZaxommcKtSi0Sq4CpHMkslndNDFDiTnJPIO02?=
 =?us-ascii?Q?avlWREFC64P1P12DlXGoScwy3fwVw9iFhFJIIOASr9AoX8OriaGfcb4JOM3x?=
 =?us-ascii?Q?5vMND0g7tx36SiWHCfFqLRvjnEOq4J9ZYLgdAPbgXMP3Ws+5cN+UbYB/BFss?=
 =?us-ascii?Q?ETBmbPfgNr7Eyavb2IaEs5u/1Lba65lMfd7YuYuFZDam3YDsaskPaR0FjJHd?=
 =?us-ascii?Q?rdDBCOx804LbDoQA/l+pxi2q+qdD8TJsAuwQ04APxPK8KzG1GqiswmdfdGnR?=
 =?us-ascii?Q?kQHC57PTbnaBv8UF1flznh+WluW4JdUq2lFncDkSDfEHCaHgHn8Fh3zCt+Yx?=
 =?us-ascii?Q?zBhOc9JjMrP+USgW/DkJme+PAlu+WjQghu2tdppox0hnyUZ+ZiNpU9YGPfPh?=
 =?us-ascii?Q?vVlE7kU4FEjIYPD3Z6wsqxe+SMf0VenqdJLXkrXjXxIS6+vjm0L3MwSao/FQ?=
 =?us-ascii?Q?TJGN3jLMYiNNamsjkKNnAcbrppCinzTyFpCg25cVWxaz1X68beXxwvE0JuUx?=
 =?us-ascii?Q?yAOKWmQjAUeDZum23fIrAuyrRv6wXb7uH5LKSoarCZ89sUaRizw6X5kUBPQv?=
 =?us-ascii?Q?o03qQGcWe3uzLvDjptXC0p+gC7/emCHdXgp2l08Sw/MhhO0cIUPs+IWcLodb?=
 =?us-ascii?Q?lDGS+SiaQ0jryro1nBxynm8hFZrZnFC6vZFHwvtveDAoewhd68fC1a026KBl?=
 =?us-ascii?Q?jmxBnYlwvpTLct7dY3QM0qSebjsWP3V9wr4qtOFAkGFIjqqImT9l9K5uSDNd?=
 =?us-ascii?Q?cvoBlpXg/Jm4+wIlqEOUpMa4dQXLAwHaqg1g0T0HlnvW6VJHj4NGOo9/1N7l?=
 =?us-ascii?Q?1J1SF5F77aqrWVj1+Xr9CC0e2QsEUDdHiBr/V3VkQjGz1fI2MCU1sS2Ly7bX?=
 =?us-ascii?Q?bY5RVHhI96TpyO107RVf8JScBA938gEzaWx2mcVqZMPrycjbjDnxN5/IxiSP?=
 =?us-ascii?Q?T2rGS5wvCx4l9rsWH32i7mrXNUl9H4btypkYAExrqZJujWJKQ2Ykbni7V1r7?=
 =?us-ascii?Q?QxCppIkNOedzmNZBGNuInNDiW8F726ToTzQ+DO++1niBznNqK2TglqgZUH0Y?=
 =?us-ascii?Q?RiV4kR5fIjQrYBUajbVL7/gr4rvT7nC+YhKqhyQ9MopwYSiROPNVQOBtCZDp?=
 =?us-ascii?Q?MTUR87awmJ5Jh4JTiIFc5/9JaL66SLyYQ53wpdaJ5oC1Nnc6qqDVyhu+Pwae?=
 =?us-ascii?Q?7Az6/Sc/gW9+fvoT8+qlZgRkUuzn3u38VWyCAjDN6ZKFQdXupX6LwvvPGsQ4?=
 =?us-ascii?Q?fLTX3zHibckI6RU5BZ0F6nWsaVWwB6PP71mPAQ1+Pk0AJfV5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b87371a-f6ef-431d-9903-08de70bef4a3
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 20:30:58.4772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9UkqsmrQcJcefXKye5fQh8fHkapOV0flu6QibAFFhJ9tNvu+Q/Z7FkAT94cb2HpJn/as8L/3bZ6apc6ypfUuRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6787
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8998-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	DBL_PROHIBIT(0.00)[0.153.128.224:email];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-0.999];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,sifive.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,0.45.198.192:email]
X-Rspamd-Queue-Id: 7DDB216AA91
X-Rspamd-Action: no action

On Sat, Feb 21, 2026 at 03:43:57AM +0800, Max Hsu wrote:
> The FU740 SoC includes a 4-channel Platform DMA (PDMA) controller.
> Add the device node to enable DMA support.
>
> Signed-off-by: Max Hsu <max.hsu@sifive.com>
> ---
>  arch/riscv/boot/dts/sifive/fu740-c000.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/sifive/fu740-c000.dtsi b/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
> index 6150f3397bff..30d0d6837c57 100644
> --- a/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
> +++ b/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
> @@ -329,6 +329,15 @@ gpio: gpio@10060000 {
>  			clocks = <&prci FU740_PRCI_CLK_PCLK>;
>  			status = "disabled";
>  		};
> +		dma: dma-controller@3000000 {

not sure sifive, generally require orderby hex address, and need empty
line between child node.

Frank
> +			compatible = "sifive,fu740-c000-pdma", "sifive,pdma0";
> +			reg = <0x0 0x3000000 0x0 0x100000>;
> +			interrupt-parent = <&plic0>;
> +			interrupts = <11>, <12>, <13>, <14>, <15>, <16>, <17>, <18>;
> +			dma-channels = <4>;
> +			clocks = <&prci FU740_PRCI_CLK_PCLK>;
> +			#dma-cells = <1>;
> +		};
>  		pcie@e00000000 {
>  			compatible = "sifive,fu740-pcie";
>  			#address-cells = <3>;
>
> --
> 2.43.0
>

