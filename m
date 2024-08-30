Return-Path: <dmaengine+bounces-3046-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0607D966509
	for <lists+dmaengine@lfdr.de>; Fri, 30 Aug 2024 17:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BE2D1C20D86
	for <lists+dmaengine@lfdr.de>; Fri, 30 Aug 2024 15:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B84A1B3B1C;
	Fri, 30 Aug 2024 15:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JIeLomoP"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2057.outbound.protection.outlook.com [40.107.105.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8AC1AD417;
	Fri, 30 Aug 2024 15:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725030684; cv=fail; b=EHWzsIVgZlbRC69TBRA/+B1LaN1uIndHmIYeLWG0P4QuJqP/0b7uJWdm03pLEkD2HN+HEs3VPJp0kqmsgI4ZxGbvk3zoOwnb8kMjNm/Fw3/1HZGH8iaxPYLJ5HpFnOFH8tmucg/l0v668GQmcymlvonbX5LY3hyq1G5QpOIltS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725030684; c=relaxed/simple;
	bh=H1By6ab7HMPImU+2T4S5enUlpfiSbuW2pBgHDp4j/ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cbf39hpTfRDA8HysBM8yi+BsyKVj7Ro8mDW7Vl2aWUmOHXnUW6C8A7ZE8zEJbxxYJFUgejdLTcyjZ/ONlaQ1wfFDfiBX2voI4kAqbdxQ5C2w7xyB4txsHQLlRsiqMa4HRkO2MIo3MZOYU6iIhYEYakQl29cp+7W4NE+H7jnkAYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JIeLomoP; arc=fail smtp.client-ip=40.107.105.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p9b0zBzV7RQzfxLeWJknm7TPxoRYUX4gybDfCg8Y0q8wr8PvLHFvt5GzWUz33ZMfhAnXYJLVWlAoHWI0XiUj/bb4AHTfBAK4hP/zuRACHW4CmIv3fU3AHgTkCnJrYI51P8e4Kp0AdRk8EVRywUaK4h4fBI9G8qLdm23grQJ5TenlI3SJ+d/8xHI1xEgBjYe2sqLlSQBpeMKxiXqRQI5pz8Tk/H7xLelcNQ/soFoXvzRONrlvzgnKNDiwgIVTVbVE7+C0d3mmFWxv9ZrXfiSDnvWdf92DgO3tpGKDYq34WTz4dq5PHHI9m0hsBk6liKlLkLjLh5cEr4hyvXqT2HyYrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGB8NuEUVtDO1e6atfMse7dkrJOSabYY9uboujHBuFQ=;
 b=k+q4pMUfZcZ1omYc5HsuuKpMUTBbrx5I5LsZiF5Vk4rKC9VOLbDWWgAMFcqzIcGMYDdu5UwKuuF+tCpjpE7/8dDw48hGliOl+IDqWgzIU43FOkuhHDgxVEz9KBLl3LeAYu9ZO6WCzMxr6E1YWQNt8wlOcXqKlzQWb7iDJDbLlZee7qW/L3mzf+Mt5pNTsqc70rD8hThJ+gkIV0N5cPYRLbM7HKT5Rw/2D6Qs4z7bbwN4+AujFRnTGujV0xov4aD+FEOR27UTVk/uLAa5u4rU5WAqrzVwIWoj7H9LngopV/CrVWshCjzV39PTKJPFtQ47MTlvTf8CXhSk8hczK0KGsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGB8NuEUVtDO1e6atfMse7dkrJOSabYY9uboujHBuFQ=;
 b=JIeLomoP9BmR/T84t256lrTKJsKik7sp90iopXq1J5LAlp6u2KpMbJkVwM/JvU/rpRoq4Wqz79IuRnc5oyoVpNL8qetQQ6iPp0+ipvjEH+0V5p/FGRioQWQ5nXWkgy06rvsocTn+EL2VPCFxCSzTpdJJM9U8KB+7iv3gWBaXXhBSl7uvgCftZTb5OGr4qx38zAP52vz1dbrl4VFu9j3dl8Ax9iAe76B6j21L6H8+o7EN15Vi6nlQtbuqY4JKVk7BTXtTMe6oqDo8RnIoLK0A90H3GxqQgT9NfSO3qovdnjyglLCZYa9rWFA6A25QsFSiMKyd5Q8f1/RljaqGpqxs1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8717.eurprd04.prod.outlook.com (2603:10a6:102:21c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Fri, 30 Aug
 2024 15:11:19 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7897.027; Fri, 30 Aug 2024
 15:11:19 +0000
Date: Fri, 30 Aug 2024 11:11:15 -0400
From: Frank Li <Frank.li@nxp.com>
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v2 5/7] dmaengine:imx-sdma:Use devm_clk_get_prepared()
 helpers
Message-ID: <ZtHhE6RQP6f/2NsI@lizhi-Precision-Tower-5810>
References: <20240830094118.15458-1-liaoyuanhong@vivo.com>
 <20240830094118.15458-6-liaoyuanhong@vivo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830094118.15458-6-liaoyuanhong@vivo.com>
X-ClientProxiedBy: BN0PR04CA0160.namprd04.prod.outlook.com
 (2603:10b6:408:eb::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8717:EE_
X-MS-Office365-Filtering-Correlation-Id: 336af392-c5d2-4c74-9513-08dcc9060063
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NCjcOuijrT0Zav33V4FPX4rZ+Sl2b9KHMq19wObpgrFpaQscnsAM+u7fr9Lv?=
 =?us-ascii?Q?fJeiFbGpuGwpdlBT4ibAjPsLtJvXzzVEod0zJZES1Cm+ncVuw9KY6DjgiXqW?=
 =?us-ascii?Q?BgGctevhsJxiMA08FMcfTMl6XSJJXLfI7Mx22Yh6TWaxQhAtpwz1cr5SywEA?=
 =?us-ascii?Q?20GOPcYLM4bEKOeUGoPf4cCXPglMt6zN+eqrF8DuTTCvZ5TAKIXG50wmsL6+?=
 =?us-ascii?Q?FJyek4EEqHT8qQjSwup4izIz0IivBLu57AIsgL5l25LmjEknz7ti3n0gjXlP?=
 =?us-ascii?Q?6UoopxTcUOA6qDh9dfBl9uY52/nmNz5FTWGmhZbMnq6lJLTSH/mDYRHRQh8m?=
 =?us-ascii?Q?u9dDbj/1wzSweBniSDxiXGxV/FrxpZJuJ/MulOMgnibjaFah4yZC3JZhfF+q?=
 =?us-ascii?Q?h6guUc62Z/XBMC+OAW0qDPHa7AFXlTPTHFJYFEnvRwduyIXGOQeZcGPfpJOb?=
 =?us-ascii?Q?ovhIf0QYDTwH6rPSTIk3rOpkFURpBvuFMTU0xB8y/Kt8Metnlsdkr7pkMBBD?=
 =?us-ascii?Q?1wuxoCOld9tODKvbTlEJI38f29o3LmHJ+NVC+XrCUbF/M4PCIm9jErwDYTAm?=
 =?us-ascii?Q?/JDVFXCVj9I/6u+c12lIytsOZtjL+73E3Z++MWONq0N36CZyN5qwSs7T6y1N?=
 =?us-ascii?Q?a68DZizyVtAg0dQKW8icninxtevbOmGWYfSYOL7gso+MOwe2xHvx2LcEiAmc?=
 =?us-ascii?Q?9e4UtpT8+aCIqOdHB45AY7LMMy1fBv0OLpsgrH2jMaQK6jxGefkikh7kcVNM?=
 =?us-ascii?Q?ZtWe6IHq9L2JArqp9ef6cRgw+ZtSZaoAEe+0c/izXB+AZcSGPcdAT71nQn7B?=
 =?us-ascii?Q?t6sGM55hOLuEsGghV7Dh63oaIdhdIxN3iz32xK0dM8opV9XzArQ2gYth+dzC?=
 =?us-ascii?Q?8ciBAOrl3FYMOpZo2YwN3yJ1YWZSx5KsO1qyqFHv6XJQW9CuGl6ac3krIeAn?=
 =?us-ascii?Q?rrET+ujU4tlI28OlFZNws4YBAZQLRGaRymrKJCzqq9JdezSXJxbX0weMD8UZ?=
 =?us-ascii?Q?D6YnA06EFeYQBguTyKqWSc9ZeLJ1jT4ha5G4ltHsvn/e2fjlosWI2wIUWqCB?=
 =?us-ascii?Q?uIzRHJn3IgWIALEmnqiGPgs748FdXH+Util1eJ/qsFwyvFkKI5wJE3QWaSHP?=
 =?us-ascii?Q?LQU43XI/0SjdAizQBn5u0CeEmyQO7F8FgOUqPeepbzuacTJI9U0IgQVxiBw1?=
 =?us-ascii?Q?oNj1WY7PJokOu07k9oPX8XjKoHcCuct3d/xfUuhYrLHILRwiTuIZzDwch8+q?=
 =?us-ascii?Q?p2rz38WJJQAgn+HksbBiiwSWYTBbH2wxQxbpvCgyMXJl3C7D3ptSZlznbwhv?=
 =?us-ascii?Q?bxqifAhF8xKKVgmf2xdFhdjT1CdyLoxLIaeoZehPtN+D+ytbBgpvQoqbg5J+?=
 =?us-ascii?Q?Pe7TlLwB3ZWIXj5C4e5zm1UXJQrWT+n9dfTJt+T3yrnTNl1eVA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WKxZSWnVIUFjO6FalRvT3/YbWmzx269299t28hXB/RorqFsuKDrDThFaktvZ?=
 =?us-ascii?Q?rRMH1pbDMHTVxgNapleaCd+5ulQmfVUwcK3rLXhMwxJqH/63uN8LAPJO12xz?=
 =?us-ascii?Q?G7Qon99neQDPF2qiSIeoLgXpkusOJ+M4pzYwxZuSouzAKlm8zvc44ZdWSjHf?=
 =?us-ascii?Q?4WPO4JQmws4plcJlbiMFZCx/0n0YtQ01hsWaBIGNB/knvTwxJv03bj6Lx8ot?=
 =?us-ascii?Q?5fiSDpOKMA29FJCELX5dFly96VDyc7Bf1Zl5r9+eGzb/gEi2e+LjLd3Ae8Xz?=
 =?us-ascii?Q?g0fqWJryLVqKyXQCfvEKH79i75UzpeuAkx5KMb4VoD26egEG7lseEPp4qU0X?=
 =?us-ascii?Q?VD6ZYG/y6End9QxKjpC8lTRl1aGOCETmeMGYuQjoJdEDbOq/ctXklPuZXe83?=
 =?us-ascii?Q?5OTLviwTb+Q070LK1GOQRGWHqQJIkFTjEQUH9v9hOJv71Ho/EBB79gOMU91x?=
 =?us-ascii?Q?U9/u6g9FcP4TExyx3gK7/1tD53CxwHST7+7BAIZEA5/m+7O5Mi4lLzdO9Edj?=
 =?us-ascii?Q?OEnYfV48QHbgIG/qah2zUwQp9JDPO0tAczdLc/HqfotguTx2qYHMQdJ+BkWy?=
 =?us-ascii?Q?vPZqNXsu+s5ypWpScgMuAU72FPmWHdGr0UUPXeGoid2joFWxSZsvgQqiOVZL?=
 =?us-ascii?Q?BkZWVjLes/Ov44ebJNRm/HWHCxmWbQAVyAIiNsskvh6e4RCTiAhoALiLhPWR?=
 =?us-ascii?Q?kPLt2/ZHnx+73YLREDYFaRg9wcKbEyMw7mSPT7TF8R7qtCpmGaJDGU8+p+EK?=
 =?us-ascii?Q?tqhnhgVZfqvtNPN0VO0r2TXWqTkB/arKguOr8Db/ZGs3wzD3ycc+tyRWMohn?=
 =?us-ascii?Q?SZY57XJpHMp2XAXGmwZdiY+QLH5ofFgMVdkJKqpf+Uqb4K2tjdgqEd7dbIxr?=
 =?us-ascii?Q?w5zlcO+Cn5DyhV02LmcFqenEe6xy0xOkakfe9g5OrIivA6MjsvP/xTxFyP5P?=
 =?us-ascii?Q?5XP0kAPzTqvpw/C2iNPTacWHKFcc3hwwllc31rqL17XtUdPVX8KQaTxu6Fa/?=
 =?us-ascii?Q?YA/0bhpKvUU060BNfDnnOgakzfosI4RAThOhLXF3WwnE+KwiR19uI2Vxhfyz?=
 =?us-ascii?Q?s6Wi5ZPCF/himos61/MGje6uUTXDQXFRnuZMKgfaSKaTW3PAi8Pi5IY7A1cA?=
 =?us-ascii?Q?xeULYt5JlpEdzthV6sXL9zEGiu7o8rIAjzsKEiH5a8/19g+ztLGtX9wtkaow?=
 =?us-ascii?Q?mw7omMor/GwM61odvBrh4lsk4sJDXuhuWF0t91CDUOLgzdjG3fbAuAAlzY4a?=
 =?us-ascii?Q?2hFwfHq/uhq/iNImK3MYy7TzW9loVXK170nou6AXBow2vy+oU/iusENJgWvk?=
 =?us-ascii?Q?h6qA4DvBANVQ4mxdwoAqDfdw+lS5nSXfi0Wm6eMfwIB1wiCUsrBCiTSHl8FK?=
 =?us-ascii?Q?vb9ZV+x9Nir02axe1V0J3NPEGJRg0n8+oJre9Id+2aJoey6eVhNaOVum4cFB?=
 =?us-ascii?Q?tAYCpW3iO2u8hsTq5RqmvOlU/viVc+8bVJhvAH98Fi8vklENLVraCpxNHUS7?=
 =?us-ascii?Q?7yi1pl1nuuL6GTBhGlglDaliNs1xqHj6VcIeVBHRiT3iGZd+c+/v0v2yZt/r?=
 =?us-ascii?Q?x52jgTG4lszf4KuQ8fErZJl6eBj31VPAtdItsPeO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 336af392-c5d2-4c74-9513-08dcc9060063
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 15:11:19.4275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OxtS9qI+L1J4cDwRaatVyUZnbMB7xWI+aTA1uN32VYkST2+EC9cSW/qujiuQ02NJv7djshTbmksKD3JxwwmkNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8717

On Fri, Aug 30, 2024 at 05:41:16PM +0800, Liao Yuanhong wrote:
> Use devm_clk_get_prepared() instead of clk functions in imx-sdma.
>
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
> v2:remove all enable related modifications, replace clk_prepare() with
> devm_clk_get_prepared()
> ---
>  drivers/dma/imx-sdma.c | 22 ++++------------------
>  1 file changed, 4 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 72299a08af44..07a017c40a82 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -2266,33 +2266,25 @@ static int sdma_probe(struct platform_device *pdev)
>  	if (IS_ERR(sdma->regs))
>  		return PTR_ERR(sdma->regs);
>
> -	sdma->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
> +	sdma->clk_ipg = devm_clk_get_prepared(&pdev->dev, "ipg");
>  	if (IS_ERR(sdma->clk_ipg))
>  		return PTR_ERR(sdma->clk_ipg);
>
> -	sdma->clk_ahb = devm_clk_get(&pdev->dev, "ahb");
> +	sdma->clk_ahb = devm_clk_get_prepared(&pdev->dev, "ahb");
>  	if (IS_ERR(sdma->clk_ahb))
>  		return PTR_ERR(sdma->clk_ahb);
>
> -	ret = clk_prepare(sdma->clk_ipg);
> -	if (ret)
> -		return ret;
> -
> -	ret = clk_prepare(sdma->clk_ahb);
> -	if (ret)
> -		goto err_clk;
> -
>  	ret = devm_request_irq(&pdev->dev, irq, sdma_int_handler, 0,
>  				dev_name(&pdev->dev), sdma);
>  	if (ret)
> -		goto err_irq;
> +		return ret;
>
>  	sdma->irq = irq;
>
>  	sdma->script_addrs = kzalloc(sizeof(*sdma->script_addrs), GFP_KERNEL);
>  	if (!sdma->script_addrs) {
>  		ret = -ENOMEM;
> -		goto err_irq;
> +		return ret;
>  	}
>
>  	/* initially no scripts available */
> @@ -2407,10 +2399,6 @@ static int sdma_probe(struct platform_device *pdev)
>  	dma_async_device_unregister(&sdma->dma_device);
>  err_init:
>  	kfree(sdma->script_addrs);
> -err_irq:
> -	clk_unprepare(sdma->clk_ahb);
> -err_clk:
> -	clk_unprepare(sdma->clk_ipg);
>  	return ret;
>  }
>
> @@ -2422,8 +2410,6 @@ static void sdma_remove(struct platform_device *pdev)
>  	devm_free_irq(&pdev->dev, sdma->irq, sdma);
>  	dma_async_device_unregister(&sdma->dma_device);
>  	kfree(sdma->script_addrs);
> -	clk_unprepare(sdma->clk_ahb);
> -	clk_unprepare(sdma->clk_ipg);
>  	/* Kill the tasklet */
>  	for (i = 0; i < MAX_DMA_CHANNELS; i++) {
>  		struct sdma_channel *sdmac = &sdma->channel[i];
> --
> 2.25.1
>

